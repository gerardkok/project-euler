original = File.read('input89.txt')

converted = original.gsub(%r{DCCCC|LXXXX|VIIII|CCCC|XXXX|IIII}, '__')

answer = original.length - converted.length

puts answer
