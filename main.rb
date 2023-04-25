require './app'

def display_options
  puts '1 - Exit and Save'
  puts '2 - List all books'
  puts '3 - List all labels'
  puts '4 - List all music albums'
  puts '5 - List all genres'
  puts '6 - List of games'
  puts '7 - List all authors'
  puts '8 - Add a book'
  puts '9 - Add a music album'
  puts '10 - Add a game'
  print 'Write the number of the option you want to choose: '
end

def run_list_option(opt)
  case opt
  when 2 then puts 'Books list'
  when 3 then puts 'Labels list'
  when 4 then puts 'Music albums list'
  when 5 then puts 'Genres list'
  when 6 then puts 'Games list'
  when 7 then puts 'Authors list'
  end
end

def run_add_option(opt)
  case opt
  when 8 then puts 'Add book'
  when 9 then puts 'Add music album'
  when 10 then puts 'Add game'
  end
end

def run_option(opt)
  case opt
  when 2..7 then run_list_option(opt)
  when 8..10 then run_add_option(opt)
  end
end

def main
  loop do
    # get option
    display_options
    opt = gets.chomp.to_i
    # evaluate option
    case opt
    when 1 then abort 'Thank you for using the app!'
    when 2..10 then run_option(opt, app)
    else
      puts 'Option not valid!'
    end
  end
end
main
