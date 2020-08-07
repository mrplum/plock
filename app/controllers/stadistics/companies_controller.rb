class Stadistics::CompaniesController < ApplicationController
  layout 'admin'

  protect_from_forgery with: :null_session

  def companies_table
    render json: Company.all
  end

  def index
    @record = 'companies'
    render 'stadistics/index'
  end

  def new
    @model = Company.new
    render 'stadistics/new'
  end

  def edit
    render 'stadistics/edit'
  end

  def create
    company = Company.new company_params
    if company.save
      redirect_to stadistics_companies_path
    else
      redirect_to new_stadistics_company_path
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
