require 'open-uri'
require 'json'

def generate_grid(grid_size)
  random = []
  random = (0...grid_size).map { ('A'..'Z').to_a.sample } until random.join.match?(/[AEIOU]/)
  return random
end

def check_letters(attempt, grid)
  counter = Hash.new(0)
  grid.each { |letter| counter[letter] += 1 }
  attempt.upcase.split("").each do |letter|
    counter[letter] -= 1
    return false if counter[letter].negative?
  end
  return true
end

def score_game_word(attempt, time, username)
  {
    time: time,
    score: attempt.length**2 / time,
    message: ["Well done #{username}! B=========D ----", "Nice bro! B=========D ----"].sample
  }
end

def score_game_no_word(time, username)
  {
    time: time,
    score: 0,
    message: ["What is that? Chinese? Hebrew? F*ck off!", "Änglisch is ä wäri hart läguasch.", "Does '#{username}' stand for f*cking retard?\nNot an english word!"].sample
  }
end

def score_game_not_in_grid(time)
  {
    time: time,
    score: 0,
    message: ["The given word is not in the grid you FOOL.", "Where the f*ck did you find that word?\nNot in the grid!", "You will never survive a rake like that.\nLook at the grid before typing!"].sample
  }
end

def score_game_too_short(time)
  {
    time: time,
    score: 0,
    message: ["Word too short. -> More than two letters B*TCH!", "Take it serious!! More than two letters!"].sample
  }
end

def run_game(attempt, grid, start_time, end_time, username)
  time = end_time - start_time
  if attempt.length <= 2
    return score_game_too_short(time)
  elsif check_letters(attempt, grid)
    word = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{attempt}").read)
    return word["found"] ? score_game_word(attempt, time, username) : score_game_no_word(time, username)
  else
    return score_game_not_in_grid(time)
  end
end

# extra:


FILEPATH = '/home/arosty/FUNGAME/'

def update_users_highscores(username, score, end_time, attempt)
  users_highscores = JSON.parse(File.read(FILEPATH + 'users_highscores.json'))
  if !users_highscores[username] || score > users_highscores[username][0]
    users_highscores[username] = Array.new(2) unless users_highscores[username]
    users_highscores[username][0] = score
    users_highscores[username][1] = end_time.to_s
    users_highscores[username][2] = attempt
    File.open(FILEPATH + 'users_highscores.json', 'wb') { |file| file.write(JSON.generate(users_highscores)) }
  end
  return users_highscores[username]
end

def overwrite_highscores(username, score, end_time, highscores, key, attempt)
  ((key + 1)..highscores.length + 1).reverse_each { |key_new| highscores[key_new.to_s] = highscores[(key_new - 1).to_s] }
  highscores[key.to_s] = [username, score, end_time.to_s, attempt]
  File.open(FILEPATH + 'highscores.json', 'wb') { |file| file.write(JSON.generate(highscores)) }
  return highscores
end

def update_highscores(username, score, end_time, attempt)
  highscores = JSON.parse(File.read(FILEPATH + 'highscores.json'))
  if score.positive?
    (1..highscores.length).each do |key|
      if score > highscores[key.to_s][1]
        highscores = overwrite_highscores(username, score, end_time, highscores, key, attempt)
        break
      end
    end
  end
  return highscores
end
