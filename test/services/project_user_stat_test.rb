require 'test_helper'

class ProjectUserStatTest < ActiveSupport::TestCase

    setup do
        @user0 = users(:one)
        @user1 = users(:user1)  
        @user2 = users(:user2)  
    end

    test "should give zero" do
        assert_equal(ProjectUserStat.new(@user0).call,0)    
    end

    test "should give ten" do
        assert_equal(ProjectUserStat.new(@user1).call,600)    
    end

    test "should give twenty" do
        assert_equal(ProjectUserStat.new(@user2).call,1200)    
    end 
end