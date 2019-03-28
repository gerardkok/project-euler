NUMBER_OF_PUZZLES = 50

def row(grid, cell)
  r = 9 * (cell / 9)
  grid.slice(r, 9)
end

def column(grid, cell)
  c = cell % 9
  grid.each_slice(9).map { |r| r[c] }
end

def box(grid, cell)
  r = 27 * (cell / 27)
  c = 3 * ((cell % 9) / 3)
  [r + c, r + c + 9, r + c + 18].flat_map { |i| grid.slice(i, 3) }
end

def unfit?(grid, cell, number)
  row(grid, cell).include?(number) || column(grid, cell).include?(number) || box(grid, cell).include?(number)
end

def solvable?(grid)
  cell = grid.index(0)
  return true unless cell

  (1..9).each do |number|
    next if unfit?(grid, cell, number)

    grid[cell] = number
    return true if solvable?(grid)

    grid[cell] = 0
  end
  false
end

def corner_number(grid)
  grid[0] * 100 + grid[1] * 10 + grid[2]
end

File.open('input96.txt') do |f|
  corners = Array.new(NUMBER_OF_PUZZLES) do
    f.readline # skip header
    grid = Array.new(9) { f.readline }.map(&:chomp).join.split('').map(&:to_i)
    solvable?(grid) ? corner_number(grid) : 0
  end
  answer = corners.reduce(:+)

  puts answer
end
