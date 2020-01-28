require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @company = companies(:one)
    @project = projects(:one)
  end

  test 'should create company' do
    c = Company.create(
      name: 'The shelby company',
      description:'Gang',
      user: @user
    )
    assert c.valid?
  end

  # validations

  test 'validate presence name' do
    c = @company
    c.name = nil
    assert_not c.valid?
  end

  test 'validate presence description' do
    c = @company
    c.description = nil
    assert_not c.valid?
  end

  test 'validate presence owner' do
    c = @company
    c.user = nil
    assert_not c.valid?
  end
  
  # associoations

  test 'owner of company exists' do
    assert_not_nil @company.user
    assert_equal(@user.name, @company.user.name)
  end

  test 'has many projects' do
    project_last_name = @company.projects.last.name
    assert_not_empty @company.projects
    assert_equal(@project.name, project_last_name)
  end

  test 'has many users' do
    name_first_name = @company.users.first.name
    assert_not_empty @company.users
    assert_equal('User Two', name_first_name)
  end
end
