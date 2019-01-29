require 'json'
require 'time'

number = 0
unless number == 'all' || number.to_i.positive?
  puts "How many scores do you want to see?\n(enter number or 'all')"
  number = gets.chomp
end
puts
puts number == 'all' ?  "****************** All time scores ******************" : "****************** Top #{number.to_s + " " * (4 - number.size)} scores ******************"
highscores = JSON.parse(File.read('/home/arosty/FUNGAME/highscores.json'))

('1'..[highscores.length, number == 'all' ? highscores.length : number.to_i].min.to_s).each do |i|
  puts " #{i}:#{" " * ([4 - i.length, 0].max)}#{highscores[i][0]}:#{" " * [10 - highscores[i][0].length - highscores[i][1].to_i.digits.length, 0].max}#{"%.4f" % highscores[i][1].round(4)} (#{highscores[i][3]})#{" " * [7 - highscores[i][3].length, 0].max}  (#{Time.parse(highscores[i][2]).strftime("%d.%m.%y at %H:%M")})"
end
puts "*****************************************************"
