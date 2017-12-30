class Page
  attr_accessor :question
  attr_accessor :task_id
  attr_accessor :level
  attr_accessor :answer

  def initialize(question, task_id, level, answer = '')
    @question = question
    @task_id = task_id
    @level = level
    @answer = answer
  end
end
