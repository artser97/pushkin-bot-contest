require 'json'
require_relative '../models/poem'

# parser json data
class Parser
  def parse
    file = File.read('./app/data/poems.json')
    JSON.parse(file)
  end
end
