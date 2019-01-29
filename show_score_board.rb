puts "*****************************************************"
seconds = Array.new(19,0.5).map.with_index { |val, index| val * (index + 2) }
letters = (3..10).to_a
# scores = Array.new(8).map.with_index do |_, letters|
#   Array.new(20).map.with_index { |time| letters**2 / seconds[time] }
# end
puts "                       letters                       "
print "       "
(3..9).each { |freq| print "  #{freq}   " }
print " 10  \n"
seconds.each_with_index do |sec, row_ind|
  print "#{(6..12).to_a.include?(row_ind) ? "seconds"[row_ind-6] : " "}#{row_ind == 18 ? "" : " "}#{"%.1f" % sec}|"
  letters.each_with_index do |let, col_ind|
    score = ((let**2).to_f / sec).round(1)
    if score >= 100
      print " "
    elsif score >= 10 || col_ind.zero?
      print "  "
    else
      print "   "
    end
    print "%.1f" % score
  end
  print "\n"
end
puts ""

puts "*****************************************************"
