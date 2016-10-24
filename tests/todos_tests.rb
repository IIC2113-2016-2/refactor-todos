require 'minitest/autorun'
require 'smarter_csv'

require 'todo'
require 'todos'

class TestTodos < Minitest::Test
  def setup
    Todos.add(Todo.new('Buy apples', 'lorem ipsum', '31/10/2016'))
  end

  def teardown
    File.delete('todos.csv') if File.exist?('todos.csv')
  end

  def test_add
    todo = Todo.new('Buy oranges', 'lorem ipsum', '01/11/2016')
    Todos.add(todo)

    rows = SmarterCSV.process('todos.csv')

    assert_equal rows[-1], { id: Todos.current_id - 1, title: 'Buy oranges', body: 'lorem ipsum', deadline: '2016-11-01' }
  end

  def test_id_should_increase_by_one
    old_id = Todos.current_id
    Todos.add(Todo.new('Buy oranges', 'lorem ipsum', '01/11/2016'))
    assert_equal old_id, Todos.current_id - 1
  end
end
