## Denotational semantics

Synonym

- fixed-point semantics
- mathematical semantics

Translate one language to another. It doesn't turn language to real behavior.

The usage is compiler & translate to formal/mathematical notatoin.

---

- http://www.schemers.org/Documents/Standards/R5RS/HTML/r5rs-Z-H-10.html#%25_sec_7.2
- http://homepages.inf.ed.ac.uk/wadler/topics/xml.html#xsl-semantics
- http://homepages.inf.ed.ac.uk/wadler/topics/xml.html#xpath-semantics

## Formal semantics

### Domain theory

- https://en.wikipedia.org/wiki/Fixed_point_(mathematics)
- https://en.wikipedia.org/wiki/Monotonic_function
- https://en.wikipedia.org/wiki/Partially_ordered_set

为了避免使用自然语言（歧义问题）和 specification by implementation。

- 能用于验证两个程序行为一致性
- 验证语言本身的正确
- 验证实现语言的抽象机器的正确


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
  
  def to_ruby
    "-> e { #{value.inspect} }"
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
  
  def to_ruby
    "-> e { (#{left.to_ruby}).call(e) + (#{right.to_ruby}).call(e) }"
  end
end

eval(Add.new(Number.new(2), Number.new(1)).to_ruby).call({})

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
  
  def to_ruby
    "-> e { (#{left.to_ruby}).call(e) * (#{right.to_ruby}).call(e) }"
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
  
  def to_ruby
    "-> e { #{value.inspect} }"
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
  
  def to_ruby
    "-> e { (#{left.to_ruby}).call(e) < (#{right.to_ruby}).call(e) }"
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
  
  def to_ruby
    "-> e { e[#{name.inspect}] }"
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
  
  def to_ruby
    '-> e { e }'
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
  
  def to_ruby
    "-> e { e.merge({ #{name.inspect} => (#{expression.to_ruby}).call(e) }) }"
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
  
  def to_ruby
    "-> e { if (#{condition.to_ruby}).call(e)" +
      " then (#{consequence.to_ruby}).call(e)" +
      " else (#{alternative.to_ruby}).call(e)" +
      " end }"
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
  
  def to_ruby
    "-> e { (#{second.to_ruby}).call((#{first.to_ruby}).call(e)) }"
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
  
  def to_ruby
    "-> e {" +
      " while (#{condition.to_ruby}).call(e); e = (#{body.to_ruby}).call(e); end;" +
      " e" +
      " }"
  end
end