class Statics::CompaniesController < ApplicationController
  layout 'admin'

  protect_from_forgery with: :null_session

  def companies_table
    render json: Company.all
  end

  def index
    @record = 'companies'
    render 'statics/index'
  end

  def new
    @model = Company.new
    render 'statics/new'
  end

  def edit
    render 'statics/edit'
  end

  def create
    company = Company.new company_params
    if company.save
      redirect_to statics_companies_path
    else
      redirect_to new_statics_company_path
    end
  end

  def update
  end

  def destroy
  end

  private
  def company_params
    params.require(:company).permit(:id, :name, :description, :company, :email, :user_id)
  end
end