# TODO: Write my_attr_reader
# TODO: Write my_attr_writer
# TODO: Write my_attr_accessor, preferably using my_attr_reader and my_attr_writer

class Class
  def my_attr_reader(*names)
    names.each do |name|
      define_method(name) { instance_variable_get("@#{name}") }
    end
  end

  def my_attr_writer(*names)
    names.each do |name|
      define_method("#{name}=") { |value| instance_variable_set("@#{name}", value) }
    end
  end

  def my_attr_accessor(*names)
    my_attr_reader(*names)
    my_attr_writer(*names)
  end
end

class Singer
  # TODO: Change to my_attr_writer
  attr_writer :first_name
  # TODO: Change to my_attr_reader
  attr_reader :last_name
  # TODO: Change to my_attr_acessor
  attr_accessor :birth_year, :greatest_hit

  def initialize(first_name, last_name, birth_year, greatest_hit)
    @first_name = first_name
    @last_name = last_name
    @birth_year = birth_year
    @greatest_hit = greatest_hit
  end

  # An example of a getter (or "reader") if we didn't use attr_reader
  def first_name
    @first_name
  end

  # An example of a setter (or "writer") if we didn't use attr_writer
  def last_name=(value)
    @last_name = value
  end

  def to_s
    "#{first_name} #{last_name}, born in #{birth_year}, greatest hit: \"#{greatest_hit}\""
  end
end

sinatra = Singer.new("Nancy", "Sinatra", 1940, "These Boots Are Made for Walkin'")

puts sinatra

sinatra.first_name = "Frank"
sinatra.birth_year = 1915
sinatra.greatest_hit = "My Way"

puts sinatra
