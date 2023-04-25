class Ask
  def date
    year = 0
    month = 0
    day = 0
    loop do
      puts 'Date'
      print 'Year: '
      year = gets.chomp.to_i
      print 'Month: '
      month = gets.chomp.to_i
      print 'Day: '
      day = gets.chomp.to_i
      return if day != 0 && month != 0 && year != 0 && month.between?(1, 12) && day.between?(1, 31)

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
end
