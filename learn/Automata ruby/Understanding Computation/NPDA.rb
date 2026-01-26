if defined? Stack
  Object.send(:remove_const, :Stack)
end

class Stack < Struct.new(:contents)
  
  def push(character)
    Stack.new([character] + contents)
  end
  
  def pop
    Stack.new(contents.drop(1))
  end
  
  def top
    contents.first
  end
  
  def inspect
    "<#Stack (#{top})#{contents.drop(1).join}>"
  end
end

if defined? PDAConfiguration
  Object.send(:remove_const, :PDAConfiguration)
end

class PDAConfiguration < Struct.new(:state, :stack)
end

class PDARule < Struct.new(:state, :character, :next_state, :pop_character, :push_characters)
  
  def apply_to?(configuration, character)
    self.state == configuration.state &&
      self.pop_character == configuration.stack.top &&
      self.character == character
  end
end

class PDARule
  
  def follow(configuration)
    PDAConfiguration.new(next_state, next_stack(configuration))
  end
  
  def next_stack(configuration)
    
    popped_stack = configuration.stack.pop
    
    push_characters.reverse.inject(popped_stack) do |stack, character|
      stack.push(character)
    end
  end
end

if defined? NPDARulebook
  Object.send(:remove_const, :NPDARulebook)
end

class NPDARulebook < Struct.new(:rules)
  
  def rules_for(configuration, character)
    
    rules.select {|rule| rule.apply_to?(configuration, character)}
  end
  
  def follow_rules_for(configuration, character)
    
    rules_for(configuration, character).map {|rule| rule.follow(configuration) }
    
  end
  
  def next_configurations(configurations, character)
    
    configurations.flat_map {|config| follow_rules_for(config, character) }.to_set
  end
  
  def follow_free_moves(configurations)
    more_configurations = next_configurations(configurations, nil)
    if more_configurations.subset?(configurations)
      configurations
    else
      follow_free_moves(configurations + more_configurations)
    end
  end
end

if defined? NPDA
  Object.send(:remove_const, :NPDA)
end

class NPDA < Struct.new(:current_configurations, :accept_states, :rulebook)
  
  def accepting?
    current_configurations.any? { |config| accept_states.include?(config.state)}
  end
  
  def read_character(character)
    self.current_configurations = rulebook.next_configurations(self.current_configurations, character)
  end
  
  def read_string(string)
    
    string.chars.each do |character|
      read_character(character)
    end
  end
  
  def current_configurations
    rulebook.follow_free_moves(super)
  end
end

if defined? NPDADesign
  Object.send(:remove_const, :NPDADesign)
end

class NPDADesign < Struct.new(:start_state, :bottom_character, :accept_states, :rulebook)
  
  def accepts?(string)
    to_npda.tap {|npda| npda.read_string(string)}.accepting?
  end
  
  def to_npda
    
    start_stack = Stack.new([bottom_character])
    
    start_configuration = PDAConfiguration.new(start_state, start_stack)
    
    NPDA.new(Set[start_configuration], accept_states, rulebook)
  end
end

rulebook = NPDARulebook.new([
  PDARule.new(1, 'a', 1, '$', ['a', '$']),
  PDARule.new(1, 'a', 1, 'a', ['a', 'a']),
  PDARule.new(1, 'a', 1, 'b', ['a', 'b']),
  PDARule.new(1, 'b', 1, '$', ['b', '$']),
  PDARule.new(1, 'b', 1, 'a', ['b', 'a']),
  PDARule.new(1, 'b', 1, 'b', ['b', 'b']),
  PDARule.new(1, nil, 2, '$', [$']),
  PDARule.new(1, nil, 2, 'a', ['a']),
  PDARule.new(1, nil, 2, 'b', ['b']),
  PDARule.new(2, 'a', 2, 'a', []),
  PDARule.new(2, 'b', 2, 'b', []),
  PDARule.new(2, nil, 3, '$', ['$'])
  ])

npda_design = NPDADesign.new(1, '$', [3], rulebook)

npda_design.accepts?('abbbbbbaa')