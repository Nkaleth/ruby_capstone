require 'securerandom'
class Author
    attr_accessor :first_name, :last_name
    def initialize(first_name,last_name,items,items,id = SecureRandom.uuid)
        @first_name = first_name
        @last_name = last_name
        @items = items
          
    end
end
