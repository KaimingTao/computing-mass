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
  
  def to_ast
    puts '222'
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

require 'treetop'
Treetop.load 'simple'

parser = SimpleParser.new
parser.parse('while ( x < 5 ) { x = x * 3 }').to_ast