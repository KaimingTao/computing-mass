- https://londmathsoc.onlinelibrary.wiley.com/doi/abs/10.1112/plms/s2-42.1.230

## UTM

### Encoding

1. to represent an entire TM on tape
2. Issue 1: any turing machine has limited state, configuration
3. Character collision between UTM and UTM simulated.

### Simulation

## Real computer

Real computer doesn't use turing machine as base model, because other equivalant model exist.

[Do real world computers use the Turing Machine mechanism?](https://cs.stackexchange.com/questions/22312/do-real-world-computers-use-the-turing-machine-mechanism)

[RAM machine](https://en.wikipedia.org/wiki/Random-access_machine#Turing_equivalence_of_the_RAM_with_indirection) is an equivalance ![Webcomic_xkcd_-_Wikipedian_protester.png](attachment:Webcomic_xkcd_-_Wikipedian_protester.png)

## Physics

Physics has many relationship with computer. Maybe from Pythagorean or Leibniz.

Simulation of physical world is an important part.


if defined? Tape
  Object.send(:remove_const, :Tape)
end

class Tape < Struct.new(:left, :middle, :right, :blank)
  
  def inspect
    "#<Tape #{left.join}(#{middle})#{right.join}>"
  end
end

tape = Tape.new(['1', '0', '1'], 1, [], '_')

class Tape
  
  def write(character)
    Tape.new(left, character, right, blank)
  end
  
  def move_head_left
    Tape.new(left[0..-2], left.last || blank, [middle] + right, blank)
  end
  
  def move_head_right
    Tape.new(left + [middle], right.first || blank, right.drop(1), blank)
  end
end

tape = Tape.new(['1', '0', '1'], 1, [], '_')
tape = tape.move_head_left
tape = tape.move_head_right
tape = tape.move_head_right
tape = tape.write(1)

if defined? TMConfiguration
  Object.send(:remove_const, :TMConfiguration)
end

class TMConfiguration < Struct.new(:state, :tape)
end

if defined? TMRule
  Object.send(:remove_const, :TMRule)
end

class TMRule < Struct.new(:state, :character, :next_state,
                          :write_character, :direction)
  
  def applies_to?(config)
    state == config.state && character == config.tape.middle
  end

end

rule = TMRule.new(1, '0', 2, '1', :right)
rule.applies_to?(TMConfiguration.new(1, Tape.new([], '0', [], '_')))
rule.applies_to?(TMConfiguration.new(1, Tape.new([], '1', [], '_')))

class TMRule
  
  def next_tape(config)
    written_tape = config.tape.write(write_character)
    
    case direction
    when :left
      written_tape.move_head_left
    when :right
      written_tape.move_head_right
    end
  end
  
  def follow(config)
    TMConfiguration.new(next_state, next_tape(config))
  end
end

rule.follow(TMConfiguration.new(1, Tape.new([], '0', [], '_')))

if defined? DTMRulebook
  Object.send(:remove_const, :DTMRulebook)
end

class DTMRulebook < Struct.new(:rules)
  
  def next_configuration(config)
    rule_for(config).follow(config)
  end
    
  def rule_for(config)
    rules.detect {|rule| rule.applies_to?(config) }
  end
end

rulebook = DTMRulebook.new([
     TMRule.new(1, '0', 2, '1', :right),
     TMRule.new(1, '1', 1, '0', :left),
     TMRule.new(1, '_', 2, '1', :right),
     TMRule.new(2, '0', 2, '0', :right),
     TMRule.new(2, '1', 2, '1', :right),
     TMRule.new(2, '_', 3, '_', :left)
   ])

tape = Tape.new(['1', '0', '1'], '1', [], '_')
configuration = TMConfiguration.new(1, tape)
configuration = rulebook.next_configuration(configuration)
configuration = rulebook.next_configuration(configuration)
configuration = rulebook.next_configuration(configuration)

if defined? DTM
  Object.send(:remove_const, :DTM)
end

class DTM < Struct.new(:current_configuration, :accept_states, :rulebook)
  
  def accepting?
    accept_states.include?(current_configuration.state)
  end
  
  def step
    self.current_configuration = rulebook.next_configuration(self.current_configuration)
  end
  
  def run
    step until accepting?
  end
end

tape = Tape.new(['1', '0', '1'], '1', [], '_')
dtm = DTM.new(TMConfiguration.new(1, tape), [3], rulebook)
dtm.run
dtm.current_configuration
dtm.accepting?

class DTMRulebook
  
  def applies_to?(config)
    !rule_for(config).nil?
  end
end

class DTM
  
  def stuck?
    !accepting? && !rulebook.applies_to?(current_configuration)
  end
  
  def run
    step until accepting? || stuck?
  end
end

tape = Tape.new(['1', '2', '1'], '1', [], '_')
dtm = DTM.new(TMConfiguration.new(1, tape), [3], rulebook)
dtm.run
dtm.stuck?

## aaabbbccc

rulebook = DTMRulebook.new([
  TMRule.new(1, 'X', 1, 'X', :right),
  TMRule.new(1, 'a', 2, 'X', :right),
  TMRule.new(1, '_', 6, '_', :left),

  TMRule.new(2, 'a', 2, 'a', :right),
  TMRule.new(2, 'X', 2, 'X', :right),
  TMRule.new(2, 'b', 3, 'X', :right),

  TMRule.new(3, 'b', 3, 'b', :right),
  TMRule.new(3, 'X', 3, 'X', :right),
  TMRule.new(3, 'c', 4, 'X', :right),

  TMRule.new(4, 'c', 4, 'c', :right),
  TMRule.new(4, '_', 5, '_', :left),
  
  TMRule.new(5, 'a', 5, 'a', :left),
  TMRule.new(5, 'b', 5, 'b', :left),
  TMRule.new(5, 'c', 5, 'c', :left),
  TMRule.new(5, 'X', 5, 'X', :left),
  TMRule.new(5, '_', 1, '_', :right)
])
tape = Tape.new([], 'a', ['a', 'a', 'b', 'b', 'b', 'c', 'c', 'c'], '_')
dtm = DTM.new(TMConfiguration.new(1, tape), [6], rulebook)

10.times { dtm.step }; dtm.current_configuration
25.times { dtm.step }; dtm.current_configuration
dtm.run; dtm.current_configuration

