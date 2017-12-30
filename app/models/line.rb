class Line
  attr_reader :str

  def initialize(line)
    @str = line
  end

  def to_s
    puts @str
  end
end
