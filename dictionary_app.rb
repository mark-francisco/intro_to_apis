# Exercise: Build a terminal dictionary app
# The program should ask the user to enter a word, then use the wordnik API to show the word’s definition: https://developer.wordnik.com/docs#!/word/getDefinitions

# Once that works, have it also display the top example and pronunciation (browse through the documentation to the top example and pronunciation).
# Bonus: Write your program in a loop such that the user can keep entering new words without having to restart the program. Give them the option of entering q to quit.
# Bonus: Search for the audio section in the documentation. Use wordnik’s audio api to get the first fileUrl to open in the browser (you’ll need to google this!) and pronounce the name of the word.

# API Key: ac6099e63826b8650f05e22c4cc08baa2f21668e3f16176fd

require "http"

system "clear"


while true
  puts "welcome to the dictionary: enter a word or type 'q' to quit:".upcase
  word = gets.chomp
  if word.downcase == 'q'
    break
  end


  response_def = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/definitions?limit=200&includeRelated=false&useCanonical=false&includeTags=false&api_key=03pgsw5yqhr4za5ql3604lcnwwdhwyznzog38048pue6ca6qy")
  parsed_data = response_def.parse
  puts "the definition of #{word} is:".upcase
  puts "#{parsed_data[0]["text"]}"

  response_example = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/examples?includeDuplicates=false&useCanonical=false&limit=5&api_key=03pgsw5yqhr4za5ql3604lcnwwdhwyznzog38048pue6ca6qy").parse
  puts "Example 1:".upcase
  puts "#{response_example["examples"][0]["text"]}"

  response_pronunciation = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/pronunciations?useCanonical=false&limit=50&api_key=03pgsw5yqhr4za5ql3604lcnwwdhwyznzog38048pue6ca6qy").parse
  puts "Pronunciation:".upcase
  puts "#{response_pronunciation[0]["raw"]}"

  response_audio = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/audio?useCanonical=false&limit=50&api_key=03pgsw5yqhr4za5ql3604lcnwwdhwyznzog38048pue6ca6qy").parse
  puts "Audio".upcase
  system("open", "#{response_audio[0]["fileUrl"]}")

end


