require 'test_helper'

class TaskTest < ActiveSupport::TestCase
   test "You can't save a task with name empty" do
     task = Task.new
     assert_not task.save
   end

   test "You can't save a task with description empty" do
     task = Task.new
     assert_not task.save
   end
end
