require 'thor'
require_relative 'todo'
require_relative 'todos'

class TodoCLI < Thor
  desc 'add', 'adds a TODO to the list according to the --title, --deadline and --body (optional) options'
  option :title, required: true
  option :deadline, required: true
  option :body
  def add
    todo = Todo.new(options[:title], options[:body], options[:deadline])
    Todos.add(todo)
  end

  desc 'ls', 'lists TODOS according to the --sort option, and filters overdue todos if the --overdue option is specified'
  option :sort
  option :overdue, type: :boolean
  def ls
    rows = Todos.list(options[:sort], options[:overdue])
    rows.each { |row| puts row.to_yaml }
  end
end
