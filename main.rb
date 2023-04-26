require './app'

def display_options
  puts '1 - Exit and Save'
  puts '2 - List all books'
  puts '3 - List all labels'
  puts '4 - List all music albums'
  puts '5 - List all genres'
  puts '6 - List all games'
  puts '7 - List all authors'
  puts '8 - Add a book'
  puts '9 - Add a music album'
  puts '10 - Add a game'
  puts '11 - Add a label'
  puts '12 - Assign item to label'
  print 'Write the number of the option you want to choose: '
end

def run_list_option(opt, app)
  case opt
  when 2 then app.list_books
  when 3 then app.list_labels
  when 4 then app.list_music_albums
  when 5 then puts 'Genres list'
  when 6 then app.list_games
  when 7 then app.list_authors
  end
end

def run_add_option(opt, app)
  case opt
  when 8 then app.add_book
  when 9 then app.add_music_album
  when 10 then app.add_game
  when 11 then app.add_label
  when 12 then app.add_label_to_item
  end
end

def run_option(opt, app)
  case opt
  when 2..7 then run_list_option(opt, app)
  when 8..12 then run_add_option(opt, app)
  end
end

def main
  app = App.new
  app.load_data
  loop do
    # get option
    display_options
    opt = gets.chomp.to_i
    # evaluate option
    case opt
    when 1
      app.save_data
      abort 'Thank you for using the app!'
    when 2..12 then run_option(opt, app)
    else
      puts 'Option not valid!'
    end
  end
end
main
