- https://github.com/google/re2
- http://patshaughnessy.net/2012/4/3/exploring-rubys-regular-expression-algorithm

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

  def follow_free_moves(states)
    more_states = next_states(states, nil)
    
    if more_states.subset?(states)
      states
    else
      follow_free_moves(states + more_states)
    end
  end
  
  def rules_for(state, character)
    rules.select { |rule| rule.apply_to?(state, character) }
  end
end

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
  
  def current_states
    rulebook.follow_free_moves(super)
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
  
  def to_nfa
    NFA.new(Set[start_state], accept_states, rulebook)
  end
  
  def accepts?(string)
    to_nfa.tap { |nfa| nfa.read_string(string) }.accepting?
  end
  
end


if defined? Pattern
  Object.send(:remove_const, :Pattern)
end

module Pattern
  def bracket(outer_precedence)
    if precedence < outer_precedence
      '(' + to_s + ')'
    else
      to_s
    end
  end
  
  def inspect
    "/#{self}/"
  end
end

if defined? Empty
  Object.send(:remove_const, :Empty)
end

class Empty
  
  include Pattern
  
  def to_s
    ''
  end
  
  def precedence
    3
  end
end

if defined? Literal
  Object.send(:remove_const, :Literal)
end

class Literal < Struct.new(:character)
  
  include Pattern
  
  def to_s
    character
  end
  
  def precedence
    3
  end

end

if defined? Concatenate
  Object.send(:remove_const, :Concatenate)
end

class Concatenate < Struct.new(:first, :second)
  include Pattern
  
  def to_s
    [first, second].map { |pattern| pattern.bracket(precedence)}.join
  end
    
  def precedence
    1
  end
end

if defined? Choose
  Object.send(:remove_const, :Choose)
end

class Choose < Struct.new(:first, :second)
  include Pattern
  
  def to_s
    [first, second].map { |pattern| pattern.bracket(precedence)}.join('|')
  end

  def precedence
    0
  end
end

if defined? Repeat
  Object.send(:remove_const, :Repeat)
end

class Repeat < Struct.new(:pattern)
  include Pattern
  
  def to_s
    pattern.bracket(precedence) + '*'
  end
  
  def precedence
    2
  end
end

pattern = 
  Repeat.new(
    Choose.new(
      Concatenate.new(
        Literal.new('a'), Literal.new('b')
        ),
      Literal.new('a')
      )
    )

class Empty
  def to_nfa_design
    start_state = Object.new
    accept_states = [start_state]
    rulebook = NFARulebook.new([])
    
    NFADesign.new(start_state, accept_states, rulebook)
  end
end

nfa_design = Empty.new.to_nfa_design
nfa_design.accepts?('')

class Literal
  def to_nfa_design
    start_state = Object.new
    accept_state = Object.new
    rule = FARule.new(start_state, character, accept_state)
    rulebook = NFARulebook.new([rule])
    
    NFADesign.new(start_state, [accept_state], rulebook)
  end
end

nfa_design = Literal.new('a').to_nfa_design
nfa_design.accepts?('b')

module Pattern
  def matches?(string)
    to_nfa_design.accepts?(string)
  end
end

Literal.new('a').matches?('b')

class Concatenate
  
  def to_nfa_design
    first_nfa_design = first.to_nfa_design
    second_nfa_design = second.to_nfa_design
    
    start_state = first_nfa_design.start_state
    accept_states = second_nfa_design.accept_states
    
    rules = first_nfa_design.rulebook.rules + second_nfa_design.rulebook.rules
    extra_rules = first_nfa_design.accept_states.map do |state|
      FARule.new(state, nil, second_nfa_design.start_state)
    end
    
    rulebook = NFARulebook.new(rules + extra_rules)
    
    NFADesign.new(start_state, accept_states, rulebook)
  end
end

Concatenate.new(Literal.new('a'), Literal.new('b')).matches?('abc')

pattern = 
  Concatenate.new(
    Literal.new('a'),
    Concatenate.new(Literal.new('a'), Literal.new('b'))
    )

pattern.matches?('aab')

class Choose
  
  def to_nfa_design
    first_nfa_design = first.to_nfa_design
    second_nfa_design = second.to_nfa_design
    
    start_state = Object.new
    
    accept_states = first_nfa_design.accept_states + second_nfa_design.accept_states
    
    rules = first_nfa_design.rulebook.rules + second_nfa_design.rulebook.rules
    
    extra_rules = [first_nfa_design, second_nfa_design].map do |nfa_design|
      FARule.new(start_state, nil, nfa_design.start_state)
    end
    
    rulebook = NFARulebook.new(rules + extra_rules)
      
    NFADesign.new(start_state, accept_states, rulebook)
      
  end
end

Choose.new(
  Literal.new('a'),
  Literal.new('b')
  ).matches?('b')

class Repeat
  
  def to_nfa_design
    
    nfa_design = pattern.to_nfa_design
    
    start_state = Object.new
    
    accept_states = nfa_design.accept_states + [start_state]
    
    rules = nfa_design.rulebook.rules
    
    extra_rules = nfa_design.accept_states.map do |state|
      FARule.new(state, nil, nfa_design.start_state)
    end
    
    more_extra_rule = FARule.new(start_state, nil, nfa_design.start_state)
    
    rulebook = NFARulebook.new(rules + extra_rules + [more_extra_rule])
    
    NFADesign.new(start_state, accept_states, rulebook)
  end
end

Repeat.new(
  Literal.new('a')).matches?('')

require 'treetop'

Treetop.load('pattern')

PatternParser.new.parse('(a(|b))*').to_ast.matches?('abba')