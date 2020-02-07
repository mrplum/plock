require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @company = companies(:one)
    @user = users(:one)
    sign_in @user
  end

  test 'should get index' do
    get companies_url
    assert_response :success
  end

  test 'should get new' do
    get new_company_url
    assert_response :success
  end

  test 'should create company' do
    Company.destroy_all
      post companies_url, params: { 
        company: {
          description: @company.description,
          name: @company.name
        } 
      }

    assert_redirected_to company_url(Company.last)
  end

  test 'should show company' do
    get company_url(@company)
    assert_response :success
  end

  test 'should get edit' do
    get edit_company_url(@company)
    assert_response :success
  end

  test 'should update company' do
    patch company_url(@company), params: {
      company: {
        description: @company.description,
        name: @company.name
      }
    }
    assert_redirected_to company_url(@company.id)
  end
end
