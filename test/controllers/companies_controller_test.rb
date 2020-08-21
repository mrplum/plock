require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @company = companies(:one)
    @user = users(:one)
    sign_in @user
  end

  test 'should create company' do
    Company.destroy_all
      post companies_url(
        locale: 'en',
        params: {
          company: {
            description: @company.description,
            name: @company.name
          }
        }
      )
    assert_redirected_to company_url(Company.last)
  end

  test 'should show company' do
    get company_url(@company, locale: 'en')
    assert_response :success
  end

  test 'should get edit' do
    get edit_company_url(@company, locale: 'en')
    assert_response :success
  end

  test 'should update company' do
    patch company_url(@company, locale: 'en'), params: {
      company: {
        description: @company.description,
        name: @company.name
      }
    }
    assert_redirected_to company_url(@company.id, locale: 'en')
  end
end
