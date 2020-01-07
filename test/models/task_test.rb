require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "You can't save a task with name empty" do

    task = Task.create(
      name: "asdasadfas",
      description: "asd",
      starts_at: Date.new,
      end_at: Date.new,
      user_id: u.id,
      project_id: p.id)
      puts task.user_id
    assert_not task.valid?
   end

   # test "You can't save a task with description empty" do
   #   task = Task.new
   #   assert_not task.save
   # end
end
