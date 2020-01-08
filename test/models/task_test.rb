require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @project = projects(:one)
  end

  test 'You can save a task' do
    task = Task.new(
      name: 'asdasadfa',
      description: 'asd',
      starts_at: Date.new,
      end_at: Date.new,
      user: @user,
      project: @project
    )
    assert task.valid?
  end
end
