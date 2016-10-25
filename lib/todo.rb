require_relative 'todos'

class Todo
  attr_reader :id
  attr_accessor :title
  attr_accessor :body
  attr_accessor :deadline

  def initialize(title, body, deadline)
    @id = Todos.current_id
    @title = title
    @body = body || '-'
    @deadline = Date.parse deadline
  end
end
