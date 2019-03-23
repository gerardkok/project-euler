OPERANDS = (1..9).to_a.freeze
OPERATORS = [:+, :-, :*, :/].freeze
OPERATOR_PERMS = OPERATORS.repeated_permutation(3).to_a.freeze

def perform(operand1, operator, operand2)
  case operator
  when :+ then operand1 + operand2
  when :- then operand1 - operand2
  when :* then operand1 * operand2
  when :/
    return nil if operand2.zero?

    Rational(operand1, operand2)
  end
end

def evaluate(expression)
  stack = []
  expression.each do |element|
    if OPERATORS.include?(element)
      operand1 = stack.pop
      operand2 = stack.pop
      element = perform(operand2, element, operand1)
      return 0 unless element
    end
    stack.push(element)
  end
  result = stack.pop.to_r
  (result.denominator == 1 && result.positive?) ? result.numerator : 0
end

def generate_expressions(operands, operators)
  [[operands[0], operands[1], operators[0], operands[2], operands[3], operators[1], operators[2]],
   [operands[0], operands[1], operators[0], operands[2], operators[1], operands[3], operators[2]]]
end

def sequence_max(operands)
  constructables = Array.new(1 + 9 * 8 * 7 * 6, false)
  operands.permutation.each do |perm|
    OPERATOR_PERMS.each do |operators|
      generate_expressions(perm, operators).each do |expr|
        constructables[evaluate(expr)] = true
      end
    end
  end
  constructables.drop(1).find_index(false)
end

answer = OPERANDS.combination(4).max_by { |combination| sequence_max(combination) }.join.to_s

puts answer
