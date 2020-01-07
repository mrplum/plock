require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  
   test "create team" do
    p  = Project.create(
      name: "Is test",
      repository: "github",
      cost: 5,
      start_at: Date.new);

    t  = Team.new(
      name: "team test",
      project_id: p.id);
    assert t.valid?
  end

end
