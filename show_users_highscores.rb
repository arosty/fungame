require 'json'
require 'time'

puts "Who's highscores do you want to see? (seperate list by ',')"
users = gets.chomp.delete(' ')
puts
puts "******************* User's scores *******************"
users_highscores = JSON.parse(File.read('/home/arosty/FUNGAME/users_highscores.json'))

users.split(",").each do |username|
  if users_highscores[username]
    puts "      #{username}:#{" " * [10 - username.length - users_highscores[username][0].to_i.digits.length, 0].max}#{"%.4f" % users_highscores[username][0].round(4)} (#{users_highscores[username][2]})#{" " * [7 - users_highscores[username][2].length, 0].max}  (#{Time.parse(users_highscores[username][1]).strftime("%d.%m.%y at %H:%M")})"
  end
end
puts "*****************************************************"

# {" " * ([10 - highscores[i][0].length - highscores[i][1].to_i.digits.length, 0].max)}
