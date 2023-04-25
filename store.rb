require 'json'

class Store
  def initialize(relative_path = 'storage')
    @relative_path = relative_path
  end

  def write(data, file_name)
    File.write("./#{@relative_path}/#{file_name}", data.to_json)
  end

  def read(file_name)
    file = File.read("./#{@relative_path}/#{file_name}")
    # if files are empty create an empty array so JSON parse don't throw an error
    file == '' ? [] : JSON.parse(file)
  end
end
