## Formal Semantics


### Operational semantics

[Operational semantics](https://en.wikipedia.org/wiki/Operational_semantics)

explain the meaning of a language by describing an interpreter.

#### Small-step

Synonym

- structural operational semantics
- transition semantics

类似于设计一个 abstract machine, 操作符号，将符号 reduce 到最终的 value, value would be a special expression

- http://www.r6rs.org/final/html/r6rs/r6rs-Z-H-15.html
- http://www.r6rs.org/refimpl/
- http://redex.racket-lang.org/
- http://caml.inria.fr/pub/docs/u3-ocaml/ocaml-ml.html#htoc5
- OCaml
- Core ML

#### Big-step

The different between big-step and small-step is, small-step try to iterately reduce to result, but big-step try to recursively directly get result.

#### Reduction semantics

### Dynamic semantics

what a program does when it's executed.

### Denotational semantics

Translate one language to another. It doesn't turn language to real behavior.

---
- [SECD machine](https://en.wikipedia.org/wiki/SECD_machine)
- [Transitions and Trees: An Introduction to Structural Operational Semantics 1st Edition](https://www.amazon.com/Transitions-Trees-Introduction-Structural-Operational/dp/0521147093)


## Parsing

- https://cjheath.github.io/treetop/

parsing expression grammar (PEG)

if defined? Number
  Object.send(:remove_const, :Number)
end

class Number < Struct.new(:value)
  def to_s
    value.to_s
  end
  
  def inspect
      "<#{self}>"
  end
  
  def reducible?
    false
  end
end

if defined? Add
  Object.send(:remove_const, :Add)
end

class Add < Struct.new(:left, :right)
  def to_s
    "#{left} + #{right}"
  end
  
  def inspect
    "<#{self}>"
  end
  
  def reducible?
    true
  end
  
  def reduce(environment)
    if left.reducible?
      Add.new(left.reduce(environment), right)
    elsif right.reducible?
      Add.new(left, right.reduce(environment))
    else
      Number.new(left.value + right.value)
    end
  end
end

if defined? Multiply
  Object.send(:remove_const, :Multiply)
end

class Multiply < Struct.new(:left, :right)
  def to_s
    "#{left} * #{right}"
  end
  
  def inspect
    "<#{self}>"
  end
  
  def reducible?
    true
  end

  def reduce(environment)
    if left.reducible?
      Multiply.new(left.reduce(environment), right)
    elsif right.reducible?
      Multiply.new(left, right.reduce(environment))
    else
      Number.new(left.value * right.value)
    end
  end
end

if defined? Boolean
  Object.send(:remove_const, :Boolean)
end

class Boolean < Struct.new(:value)
  def to_s
    value.to_s
  end
  
  def inspect
    "<#{self}>"
  end

  def reducible?
    false
  end
end

if defined? LessThan
  Object.send(:remove_const, :LessThan)
end

class LessThan < Struct.new(:left, :right)
  def to_s
    "#{left} < #{right}"
  end
  
  def inspect
    "<#{self}>"
  end
  
  def reducible?
    true
  end
  
  def reduce(environment)
    if left.reducible?
      LessThan.new(left.reduce(environment), right)
    elsif right.reducible?
      LessThan.new(left, right.reduce(environment))
    else
      Boolean.new(left.value < right.value)
    end
  end
end

if defined? Variable
  Object.send(:remove_const, :Variable)
end

class Variable < Struct.new(:name)
  def to_s
    name.to_s
  end
  
  def inspect
    "<#{self}>"
  end
  
  def reducible?
    true
  end
  
  def reduce(environment)
    environment[name]
  end
end

if defined? DoNothing
  Object.send(:remove_const, :DoNothing)
end

class DoNothing
  def to_s
    'do-nothing'
  end
  
  def inspect
    "<#{self}>"
  end
  
  def ==(other_statement)
    other_statement.instance_of?(DoNothing)
  end
  
  def reducible?
    false
  end
end

if defined? Assign
  Object.send(:remove_const, :Assign)
end

class Assign < Struct.new(:name, :expression)
  def to_s
    "#{name} = #{expression}"
  end
  
  def inspect
    "<#{self}>"
  end
  
  def reducible?
    true
  end
  
  def reduce(environment)
    if expression.reducible?
      [Assign.new(name, expression.reduce(environment)), environment]
    else
      [DoNothing.new, environment.merge({name => expression})]
    end
  end
end

if defined? If
  Object.send(:remove_const, :If)
end

class If < Struct.new(:condition, :consequence, :alternative)
  def to_s
    "if (#{condition}) { #{consequence} } else { #{alternative} }"
  end
  
  def inspect
    "<#{self}>"
  end
  
  def reducible?
    true
  end
  
  def reduce(environment)
    if condition.reducible?
      [If.new(condition.reduce(environment), consequence, alternative), environment]
    else
      case condition
      when Boolean.new(true)
        [consequence, environment]
      when Boolean.new(false)
        [alternative, environment]
      end
    end
  end
end

if defined? Sequence
  Object.send(:remove_const, :Sequence)
end

class Sequence < Struct.new(:first, :second)
  def to_s
    "#{first}; #{second}"
  end
  
  def inspect
    "<#{self}>"
  end
  
  def reducible?
    true
  end
  
  def reduce(environment)
    case first
    when DoNothing.new
      [second, environment]
    else
      reduced_first, reduced_environment = first.reduce(environment)
      [Sequence.new(
        reduced_first,
        second
        ),
        reduced_environment]
    end
  end
end

if defined? While
  Object.send(:remove_const, :While)
end

class While < Struct.new(:condition, :body)
  def to_s
    "while (#{condition}) { #{body} }"
  end
  
  def inspect
    "<#{self}>"
  end
  
  def reducible?
    true
  end
  
  def reduce(environment)
    [If.new(condition, Sequence.new(body, self), DoNothing.new), environment]
  end
end

## Machine
if defined? Machine
  Object.send(:remove_const, :Machine)
end

class Machine < Struct.new(:statement, :environment)
  def step
    self.statement, self.environment = statement.reduce(environment)
  end
  
  def run
    while statement.reducible?
      puts "#{statement}, #{environment}"
      step
    end
    
    puts "#{statement}, #{environment}"
  end
end

# Machine.new(
#   Add.new(
#     Multiply.new(Number.new(1), Number.new(2)),
#     Multiply.new(Number.new(3), Number.new(4))
#   )
# ).run()

# Machine.new(
#   LessThan.new(
#     Multiply.new(Number.new(1), Number.new(2)),
#     Multiply.new(Number.new(3), Number.new(4))
#   )
# ).run()

# Machine.new(
#   Add.new(Variable.new(:x), Variable.new(:y)),
#   {x: Number.new(5), y: Number.new(6)}
#   ).run

Machine.new(
  Assign.new(
    :x, 
    Add.new(Variable.new(:x), Number.new(1))
    ),
  {x: Number.new(2)}
).run

Machine.new(
  If.new(
    Variable.new(:x), 
    Assign.new(:x, Number.new(3)),
    Assign.new(:x, Number.new(4)),
      ),
  {x: Boolean.new(true)}
).run

Machine.new(
  Sequence.new(
    Sequence.new(
      Assign.new(:x, Number.new(1)),
      Assign.new(:y, Number.new(2))
      ),
    Assign.new(:z, Number.new(3))
    ),
  {}
  ).run

Machine.new(
  While.new(
    LessThan.new(Variable.new(:x), Number.new(5)),
    Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(2)))
    ),
  {x: Number.new(1)}
).run

require 'treetop'
Treetop.load 'simple'

parser = SimpleParser.new
statement = parser.parse('while ( x < 5 ) { x = x * 3 }').to_ast


