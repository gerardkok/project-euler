NUMBER_OF_PUZZLES = 50

File.open('input96.txt') do |f|
  50.times do
    f.readline # skip header
    grid = 9.times.map { f.readline }.map(&:chomp).join.split('').map(&:to_i)
    puts grid.to_s
  end
end
