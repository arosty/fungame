require 'pry-byebug'
require 'time'
require_relative "longest_word"

puts "******** Welcome to the longest word game! ********"
first_round = true
puts "Username:"
username = gets.chomp.delete(' ')
while username == "" || username.length > 8
  if username.length.zero?
    puts "Who are you mothaf*cka?"
  else
    puts "Max 8 letters you selfish mothaf*cka:"
  end
  username = gets.chomp.delete(' ')
end
while true
  unless first_round
    puts "Username:\n(Enter for '#{username}' or 'exit' to end the game)"
    input = gets.chomp.delete(' ')
    username = input == "" ? username : input
  end
  while username.length > 8
    puts "max 8 letters you selfish mothaf*cka:"
    username = gets.chomp.delete(' ')
  end
  break if username == "exit"
  puts
  (-3..-1).each do |i|
    print "#{-i}... "
    sleep(0.5)
  end
  if rand(30).zero?
    puts "\n\nYou f*ckin idiot seriously think I will give you a grid?\nWhy should I? F*ck off!"
    sleep(3.5)
    puts "*****************************************************"
    puts
  else
    print "   GO!\n\n"
    puts "Here is your grid, #{username}:"
    grid = generate_grid(10)
    puts grid.join(" ")
    puts "*****************************************************"

    puts "What's your best shot?"
    start_time = Time.now
    attempt = gets.chomp.tr('^A-Za-z', '')
    end_time = Time.now
    puts
    result = run_game(attempt, grid, start_time, end_time, username)
    puts result[:message]
    puts
    sleep (1.5)
    puts "****************** Now your result ******************"
    puts "Your word: #{attempt}"
    puts "Time Taken to answer: #{result[:time]}"
    puts "Your score: #{result[:score]}"
    puts "******************* In the record *******************"
    user_highscore = update_users_highscores(username, result[:score], end_time, attempt)
    puts "Your highscore:"
    puts "    #{username}:#{" " * (10 - username.length - user_highscore[0].floor.digits.length)}#{"%.4f" % user_highscore[0].round(4)} (#{user_highscore[2]})#{" " * (8 - user_highscore[2].length)}  (#{Time.parse(user_highscore[1]).strftime("%d.%m.'%y at %H:%M")})"
    highscores = update_highscores(username, result[:score], end_time, attempt)
    puts "Overall highscore:"
    ('1'..'5').each do |i|
      puts " #{i}: #{highscores[i][0]}:#{" " * (10 - highscores[i][0].length - highscores[i][1].floor.digits.length)}#{"%.4f" % highscores[i][1].round(4)} (#{highscores[i][3]})#{" " * (8 - highscores[i][3].length)}  (#{Time.parse(highscores[i][2]).strftime("%d.%m.'%y at %H:%M")})"
    end
    puts "*****************************************************"
    puts
  end
  first_round = false
end
