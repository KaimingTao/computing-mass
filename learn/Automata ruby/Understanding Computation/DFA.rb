# if defined? FARule
#   Object.send(:remove_const, :FARule)
# end

class FARule < Struct.new(:state, :character, :next_state)
  
  def apply_to?(state, character)
    self.state == state && self.character == character
  end
  
  def follow
    next_state
  end
  
  def inspect
    "#<FARule #{state.inspect} --#{character}--> #{next_state.inspect}>"
  end
  
end

FARule.new(1, 'b', 2)

if defined? DFARulebook
  Object.send(:remove_const, :DFARulebook)
end

class DFARulebook < Struct.new(:rules)
  
  def next_state(state, character)
    rule = rule_for(state, character)
    puts rule.inspect
    rule.follow
  end
    
  def rule_for(state, character)
    rules.detect { |rule| rule.apply_to?(state, character) }
  end
end

rulebook = DFARulebook.new([
  FARule.new(1, 'a', 2),
  FARule.new(2, 'a', 2),
  FARule.new(3, 'a', 3),
  FARule.new(1, 'b', 1),
  FARule.new(2, 'b', 3),
  FARule.new(3, 'b', 3)
  ])

puts rulebook.next_state(1, 'a')
puts rulebook.next_state(1, 'b')
puts rulebook.next_state(2, 'b')

if defined? DFA
  Object.send(:remove_const, :DFA)
end

class DFA < Struct.new(:current_state, :accepting_states, :rulebook)
  
  def accepting?
    accepting_states.include?(current_state)
  end
  
  def read_character(character)
    self.current_state = self.rulebook.next_state(self.current_state, character)
  end
  
  def read_string(string)
    string.chars.each do |character|
      read_character(character)
    end
  end
end

puts DFA.new(2, [1], rulebook).accepting?

puts DFA.new(1, [3], rulebook).read_character('b')
  
dfa = DFA.new(1, [3], rulebook)
dfa.read_string('abaab')
dfa.accepting?

if defined? DFADesign
  Object.send(:remove_const, :DFADesign)
end

class DFADesign < Struct.new(:start_state, :accept_states, :rulebook)
  
  def to_dfa
    DFA.new(start_state, accept_states, rulebook)
  end
  
  def accept?(string)
    to_dfa.tap {|dfa| dfa.read_string(string)}.accepting?
  end
end

DFADesign.new(
  1,
  [3],
  rulebook
  ).accept?('abaab')