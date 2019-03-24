OPERANDS = (1..9).to_a.freeze
NUMBER_OF_OPERANDS = 4
OPERATORS = [:+, :-, :*, :/].freeze
NUMBER_OF_OPERATORS = NUMBER_OF_OPERANDS - 1
OPERATOR_PERMS = OPERATORS.repeated_permutation(NUMBER_OF_OPERATORS).to_a.freeze

def perform(operand1, operator, operand2)
  case operator
  when :+ then operand1 + operand2
  when :- then operand1 - operand2
  when :* then operand1 * operand2
  when :/
    return nil if operand2.zero? # don't allow division by zero

    Rational(operand1, operand2)
  end
end

def templates(number_of_operators = 0)
  return [[:operand]] if number_of_operators.zero?

  (0..(number_of_operators - 1) / 2).each_with_object([]) do |l, acc|
    left_trees = templates(l)
    right_trees = templates(number_of_operators - l - 1)
    left_trees.each do |left|
      right_trees.each do |right|
        acc << left + right + [:operator]
      end
    end
  end
end

TEMPLATES = templates(NUMBER_OF_OPERATORS).freeze

def evaluate(template, operands, operators)
  stack = []
  current_operand = current_operator = 0
  template.each do |element|
    if element == :operator
      outcome = perform(stack.pop, operators[current_operator], stack.pop)
      return 0 unless outcome

      stack.push(outcome)
      current_operator += 1
    else
      stack.push(operands[current_operand])
      current_operand += 1
    end
  end
  result = stack.pop.to_r
  (result.denominator == 1 && result.positive?) ? result.numerator : 0
end

def sequence_max(operands)
  max = OPERANDS.last(NUMBER_OF_OPERANDS).reduce { |acc, i| i * acc } + 1
  constructables = Array.new(max, false)
  operands.permutation.each do |perm|
    OPERATOR_PERMS.each do |operators|
      TEMPLATES.each do |template|
        constructables[evaluate(template, perm, operators)] = true
      end
    end
  end
  constructables.drop(1).find_index(false)
end

answer = OPERANDS.combination(NUMBER_OF_OPERANDS).max_by { |combination| sequence_max(combination) }.join.to_s

puts answer
