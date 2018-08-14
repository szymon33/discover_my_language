require_relative 'discover_my_language'

puts 'Type Github username and press enter:'
username = gets.chomp
puts DiscoverMyLanguage.new(username).build
