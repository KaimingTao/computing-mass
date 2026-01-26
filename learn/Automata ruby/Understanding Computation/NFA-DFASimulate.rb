if defined? FARule
  Object.send(:remove_const, :FARule)
end

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
  
  def accepts?(string)
    to_dfa.tap {|dfa| dfa.read_string(string)}.accepting?
  end
end

DFADesign.new(
  1,
  [3],
  rulebook
  ).accepts?('abaab')

if defined? NFARulebook
  Object.send(:remove_const, :NFARulebook)
end

require('set')

class NFARulebook < Struct.new(:rules)
  
  def next_states(states, character)
    states.flat_map { |state| follow_rules_for(state, character)}.to_set
  end
  
  def follow_rules_for(state, character)
     rules_for(state, character).map(&:follow)
  end
    
  def rules_for(state, character)
    rules.select { |rule| rule.apply_to?(state, character) }
  end
end

rulebook = NFARulebook.new(
  [
    FARule.new(1, 'a', 1),
    FARule.new(1, 'b', 1),
    FARule.new(1, 'b', 2),
    FARule.new(2, 'a', 3),
    FARule.new(2, 'b', 3),
    FARule.new(3, 'a', 4),
    FARule.new(3, 'b', 4)
  ]
  )

rulebook.next_states(Set[1], 'b')

## Simulation

### TODO: translate Ruby NFA to graphy

if defined? NFA
  Object.send(:remove_const, :NFA)
end

class NFA < Struct.new(:current_states, :accept_states, :rulebook)
  
  def accepting?
    (current_states & accept_states).any?
  end
  
  def read_character(character)
    self.current_states = rulebook.next_states(self.current_states, character)
  end
  
  def read_string(string)
    string.chars.each do |character|
      read_character(character)
    end
  end
end

if defined? NFADesign
  Object.send(:remove_const, :NFADesign)
end

class NFADesign < Struct.new(:start_state, :accept_states, :rulebook)
  def to_nfa(current_states=Set[start_state])
    NFA.new(current_states, accept_states, rulebook)
  end
  def accepts?(string)
    to_nfa.tap { |nfa| nfa.read_string(string) }.accepting?
  end
end

nfa_design = NFADesign.new(
  1,
  [4],
  rulebook)

nfa_design.accepts?('bbabb')

## Free move

class NFARulebook
    
  def follow_free_moves(states)
    more_states = next_states(states, nil)
    
    if more_states.subset?(states)
      states
    else
      follow_free_moves(states + more_states)
    end
  end
  
end

rulebook = NFARulebook.new(
  [
    FARule.new(1, nil, 2),
    FARule.new(1, nil, 4),
    FARule.new(2, 'a', 3),
    FARule.new(3, 'a', 2),
    FARule.new(4, 'a', 5),
    FARule.new(5, 'a', 6),
    FARule.new(6, 'a', 4)
  ]
  )

rulebook.follow_free_moves(Set[1])

class NFA
  
  def current_states
    rulebook.follow_free_moves(super)
  end
end

nfa_design = NFADesign.new(1, [2, 4], rulebook)

nfa_design.accepts?('aaaaa')

rulebook = NFARulebook.new([
  FARule.new(1, 'a', 1),
  FARule.new(1, 'a', 2),
  FARule.new(1, nil, 2),
  FARule.new(2, 'b', 3),
  FARule.new(3, 'b', 1),
  FARule.new(3, nil, 2)
  ])

nfa_design = NFADesign.new(1, [3], rulebook)
nfa_design.to_nfa.current_states

nfa_design.to_nfa(Set[2]).current_states

nfa_design.to_nfa(Set[3]).current_states


if defined? NFASimulation
  Object.send(:remove_const, :NFASimulation)
end

class NFASimulation < Struct.new(:nfa_design)
  def next_state(state, character)
    nfa_design.to_nfa(state).tap do |nfa|
      nfa.read_character(character)
    end.current_states
  end
end

simulation = NFASimulation.new(nfa_design)

simulation.next_state(Set[1, 2], 'b')


class NFARulebook
  
  def alphabet
    rules.map(&:character).compact.uniq
  end
  
end

class NFASimulation
  def rule_for(state)
    nfa_design.rulebook.alphabet.map do |character|
      FARule.new(state, character, next_state(state, character))
    end
  end
end

puts rulebook.alphabet

puts simulation.rule_for(Set[1, 2])

class NFASimulation
  
  def discover_states_and_rules(states)
    
    rules = states.flat_map {|state| rule_for(state)}
    
    more_states = rules.map(&:follow).to_set
    
    if more_states.subset?(states)
      [states, rules]
    else
      discover_states_and_rules(states + more_states)
    end
  end
end

start_state = nfa_design.to_nfa.current_states

simulation.discover_states_and_rules(Set[start_state])

class NFASimulation
  
  def to_dfa_design
    
    start_state = nfa_design.to_nfa.current_states
    
    states, rules = discover_states_and_rules(Set[start_state])
    accept_states = states.select {|state| nfa_design.to_nfa(state).accepting? }

    DFADesign.new(start_state, accept_states, DFARulebook.new(rules))
  end
end


dfa_design = simulation.to_dfa_design

dfa_design.accepts?('bbbabb')


## Todo

Minimal DFA algorithm