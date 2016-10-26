require 'yaml'
require 'csv'
require 'smarter_csv'

class Todo
  attr_reader :id
  attr_accessor :title
  attr_accessor :body
  attr_accessor :deadline

  def initialize(title, body, deadline)
    @id = Todo.current_id
    @title = title
    @body = body || '-'
    @deadline = Date.parse deadline
  end

  def save
    unless File.exist?('todos.csv')
      CSV.open('todos.csv', 'a+') { |csv| csv << %w(id title body deadline) }
    end

    CSV.open('todos.csv', 'a+') { |csv| csv << [self.id, self.title, self.body, self.deadline] }
  end

  def self.list(sort, overdue)
    unless File.exist?('todos.csv')
      CSV.open('todos.csv', 'a+') { |csv| csv << %w(id title body deadline) }
    end

    rows = SmarterCSV.process('todos.csv')

    if sort
      if overdue
        rows.reject! { |hash| Date.parse(hash[:deadline]) > DateTime.now.to_date }

        if sort == 'deadline'
          rows.sort_by! { |hash| Date.parse hash[sort.to_sym] }
        else
          rows.sort_by! { |hash| hash[sort.to_sym] }
        end
      else
        if sort == 'deadline'
          rows.sort_by! { |hash| Date.parse hash[sort.to_sym] }
        else
          rows.sort_by! { |hash| hash[sort.to_sym] }
        end
      end
    elsif overdue
      rows.reject { |hash| Date.parse(hash[:deadline]) > DateTime.now.to_date }
    else
      rows
    end
  end

  def self.current_id
    unless File.exist?('todos.csv')
      CSV.open('todos.csv', 'a+') { |csv| csv << %w(id title body deadline) }
    end

    rows = SmarterCSV.process('todos.csv')
    rows.size == 0 ? 1 : (rows.map { |hash| hash[:id] }.max + 1)
  end
end
