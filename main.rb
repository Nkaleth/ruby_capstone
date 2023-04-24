def main
  loop do
    puts '1 - List all books'
    puts '2 - List all labels'
    puts '3 - List all music albums'
    puts '4 - List all genres'
    puts '5 - List of games'
    puts '6 - List all authors'
    puts '7 - Add a book'
    puts '8 - Add a music album'
    puts '9 - Add a game'
    puts '10 - Exit and Save'
    print 'Write the number of the option you want to choose: '
    opt = gets.chomp.to_i

    case opt
    when 1
      puts 'Books list'
    when 2
      puts 'Labels list'
    when 3
      puts 'Music albums list'
    when 4
      puts 'Genres list'
    when 5
      puts 'Games list'
    when 6
      puts 'Authors list'
    when 7
      puts 'Add book'
    when 8
      puts 'Add music album'
    when 9
      puts 'Add game'
    when 10
      abort 'Thank you for using the app!'
    else
      puts 'Option not valid!'
    end
  end
end
main
