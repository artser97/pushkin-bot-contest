require_relative 'line'

class Poem
  attr_reader :name, :lines

  def initialize(name, text)
    @name = name
    @lines = []
    text.each do |line|
      @lines.push(Line.new(line))
    end
  end

  def to_s
    puts @name
    puts
    @lines.each(&:to_s)
    puts
  end
end
