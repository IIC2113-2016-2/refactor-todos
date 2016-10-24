require 'yaml'
require 'csv'
require 'smarter_csv'

class Todos
  def self.add(todo)
    unless File.exist?('todos.csv')
      CSV.open('todos.csv', 'a+') { |csv| csv << %w(id title body deadline) }
    end

    CSV.open('todos.csv', 'a+') { |csv| csv << [todo.id, todo.title, todo.body, todo.deadline] }
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
