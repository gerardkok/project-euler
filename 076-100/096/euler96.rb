# algorithm from https://norvig.com/sudoku.html

NUMBER_OF_PUZZLES = 50

def ranges(cell)
  row_start = 9 * (cell / 9)
  row_range = (row_start...row_start + 9).to_a
  column_start = cell % 9
  column_range = Array.new(9) { |i| i * 9 + column_start }
  box_start = 27 * (cell / 27) + 3 * (column_start / 3)
  box_range = [box_start, box_start + 9, box_start + 18].flat_map { |i| Array.new(3) { |j| i + j } }
  [row_range, column_range, box_range]
end

RANGES = Array.new(81) { |cell| ranges(cell) }.freeze
PEERS = RANGES.map.each_with_index { |range, i| range.flatten.uniq.reject { |c| c == i } }.freeze

def eliminate_from_range(number, range, markup)
  cells_for_number = range.select { |c| markup[c].include?(number) }
  return cells_for_number.length.positive? unless cells_for_number.length == 1

  assign(number, cells_for_number.sample, markup)
end

def eliminate_from_ranges(number, cell, markup)
  RANGES[cell].all? { |range| eliminate_from_range(number, range, markup) }
end

def eliminate_from_peers(cell, markup)
  contents = markup[cell]
  return contents.length.positive? unless contents.length == 1

  PEERS[cell].all? { |peer| eliminate(contents.sample, peer, markup) }
end

def eliminate(number, cell, markup)
  return true unless markup[cell].include?(number)

  markup[cell].delete(number)
  eliminate_from_peers(cell, markup) && eliminate_from_ranges(number, cell, markup)
end

def assign(number, cell, markup)
  numbers_to_eliminate = markup[cell] - [number]
  numbers_to_eliminate.all? { |n| eliminate(n, cell, markup) }
end

def markup(grid)
  markup = Array.new(81) { (1..9).to_a }
  grid.each_with_index.each_with_object(markup) do |(number, cell), acc|
    next if number.zero?

    assign(number, cell, acc)
  end
end

def solved?(markup)
  markup.all? { |m| m.length == 1 }
end

def solvable?(markup)
  return true if solved?(markup)

  contents, cell = markup.each_with_index.select { |c, _| c.length > 1 }.min_by { |c, _| c.length }
  contents.each do |number|
    markup_dup = Array.new(81) { |i| markup[i].dup }
    next unless assign(number, cell, markup_dup)

    if solvable?(markup_dup)
      markup.replace(markup_dup)
      return true
    end
  end
  false
end

def corner_number(markup)
  markup[0].sample * 100 + markup[1].sample * 10 + markup[2].sample
end

File.open('input96.txt') do |f|
  corners = Array.new(NUMBER_OF_PUZZLES) do
    f.readline # skip header
    grid = Array.new(9) { f.readline }.map(&:chomp).join.split('').map(&:to_i)
    markup = markup(grid)
    solvable?(markup) ? corner_number(markup) : 0
  end
  answer = corners.reduce(:+)

  puts answer
end
