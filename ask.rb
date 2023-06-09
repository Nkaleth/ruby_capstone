class Ask
  def date(message = 'Date')
    year = 0
    month = 0
    day = 0
    loop do
      puts message
      print 'Year: '
      year = gets.chomp.to_i
      print 'Month: '
      month = gets.chomp.to_i
      print 'Day: '
      day = gets.chomp.to_i
      break if day != 0 && month != 0 && year != 0 && month.between?(1, 12) && day.between?(1, 31)

      puts 'Invalid date!'
    end
    Date.new(year, month, day)
  end

  def boolean(question)
    valid_answers = %w[Y N]
    loop do
      print "#{question} [Y/N]: "
      answer = gets.chomp
      return (answer.upcase == 'Y') if valid_answers.include?(answer.upcase)

      puts 'Invalid answer!'
    end
  end

  def string(question)
    loop do
      print "#{question}: "
      answer = gets.chomp
      return answer if answer != ''

      puts 'You can\'t submit an empty answer!'
    end
  end

  def option(question, options)
    puts question
    # display options
    options.each_with_index { |option, num| puts "#{num + 1}) #{option}" }
    loop do
      print 'Write the number according to the option you want to choose: '
      answer = gets.chomp.to_i
      return options[answer - 1] if answer.between?(1, options.length)

      puts 'Option not valid!'
    end
  end

  def number_between(max, min = 0)
    loop do
      print 'Write the number of the item you want to select: '
      option = gets.chomp.to_i
      return option if option.between?(min, max)

      puts 'Number is not valid!'
    end
  end
end
