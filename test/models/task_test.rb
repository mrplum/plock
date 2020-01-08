require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    @project = projects(:one)
  end

  test "You can save a task" do
    task = Task.new(
      name: "asdasadfas",
      description: "asd",
      starts_at: Date.new,
      end_at: Date.new,
      user: @user,
      project: @project)
    assert task.valid?
   end

   # test "You can't save a task with description empty" do
   #   task = Task.new
   #   assert_not task.save
   # end
end
