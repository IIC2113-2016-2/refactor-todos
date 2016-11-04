require 'minitest/autorun'

require 'todo'

class TestTodo < Minitest::Test
  def setup
    Todo.new('Buy apples', 'lorem ipsum', '31/10/2016').save
  end

  def teardown
    File.delete('todos.csv') if File.exist?('todos.csv')
  end

  def test_add
    Todo.new('Buy oranges', 'lorem ipsum', '01/11/2016').save

    rows = SmarterCSV.process('todos.csv')

    assert_equal rows[-1], { id: Todo.current_id - 1, title: 'Buy oranges', body: 'lorem ipsum', deadline: '2016-11-01' }
  end

  def test_id_should_increase_by_one
    old_id = Todo.current_id
    Todo.new('Buy oranges', 'lorem ipsum', '01/11/2016').save
    assert_equal old_id, Todo.current_id - 1
  end
end
