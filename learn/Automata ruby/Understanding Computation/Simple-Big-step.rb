## Big-step

Synonym

- natural semantics
- relational semantics

--- 

- http://www.lfcs.inf.ed.ac.uk/reports/87/ECS-LFCS-87-36/
- http://caml.inria.fr/pub/docs/u3-ocaml/ocaml-ml.html#htoc7
- https://www.w3.org/TR/xquery-semantics/
- https://www.w3.org/TR/xpath-full-text-30/

# RubyVM::InstructionSequence.compile_option = {
#   tailcall_optimization: true,
#   trace_instruction: false
#   }

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
  
  def eval(environment)
    self
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
  
  def eval(environment)
    self
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
  
  def eval(environment)
    environment[name]
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

  def eval(environment)
    Number.new(left.eval(environment).value + right.eval(environment).value)
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
  
  def eval(environment)
    Number.new(left.eval(environment).value * right.eval(environment).value)
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
  
  def eval(environment)
    Boolean.new(left.eval(environment).value < right.eval(environment).value)
  end
end

Number.new(23).eval({})

Variable.new(:x).eval({x: Number.new(5)})

LessThan.new(
  Number.new(6), Number.new(4)).eval({})

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
  
  def eval(environment)
    environment.merge({name: expression.eval(environment)})
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
  
  def eval(environment)
    environment
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
  
  def eval(environment)
    case condition.eval(environment)
    when Boolean.new(true)
      consequence.eval(environment)
    when Boolean.new(false)
      consequence.evaluate(environment)
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
  
  def eval(environment)
    second.eval(first.eval(environment))
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
  
  def eval(environment)
    case condition.eval(environment)
    when Boolean.new(true)
      eval(body.eval(environment))
    when Boolean.new(false)
      environment
    end
  end
end

RubyVM::InstructionSequence.compile_option = {
  tailcall_optimization: true,
  trace_instruction: false
  }

statement = 
  While.new(
    LessThan.new(Variable.new(:x), Number.new(5)),
    Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(2)))
    )
statement.eval({x: Number.new(4)})