require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  
   test "create team" do
    t  = Team.new(name: "team test")
    assert t.valid?
  end

end
