require 'yaml'

def save_game
    puts "How would you like to name the file?"
    namefile = gets.chomp.to_s.downcase

    File.open("saves/#{namefile}.yaml", 'w') { |file| file.write(YAML.dump(self)) }
  end
  