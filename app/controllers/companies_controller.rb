# #Company class used for create company for add users to work
class CompaniesController < ApplicationController
  before_action :get_company, only: %i[show edit update]
  before_action :authenticate_user!, except: %i[accept_invitation_to_company]
  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @projects = @company.projects
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit; end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params.merge({owner_id: current_user.id}))

    respond_to do |format|
      if @company.save
        current_user.company_id = @company.id
        current_user.incorporated_at = DateTime.now
        @user = current_user
        if @user.save!
          format.html { redirect_to @company, notice: 'Company was successfully created.' }
          format.json { render :show, status: :created, location: @company }
        else
          format.html { render :new }
          format.json { render json: @company.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def send_email
    email = params[:user][:email]
    pass = "password"
    @company = Company.find_by(id: params[:company_id])
    @user = User.new(name: "your name", lastname: "your lastname", email: email, password: pass, company_id: params[:company_id], incorporated_at: DateTime.now)
    respond_to do |format|
      if @user.save
        UserMailer.with( company: @company, user: @user).welcome_to_company.deliver_later
        format.html { redirect_to @user }
        format.json { render :show, status: :created, location: company_subscribe_user_path }
      else
        format.html { render :_addUsers, user: @user }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
    
    def subscribe_user
      company_id = params[:company_id]
      @company = Company.find_by(id: company_id)
      @user = User.find(@company.id)
      respond_to do |format|
        format.html { render :_addUsers, user: @user  }
        format.json { render :show, status: :created, location: company_subscribe_user_path }
      end
    end
    
  def accept_invitation_to_company
    redirect_to edit_user_path(params[:owner_id])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def get_company
    @company = Company.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.require(:company).permit(:id, :name, :description, :company, :email, :owner_id)
  end
end
