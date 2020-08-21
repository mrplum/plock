# frozen_string_literal: true

# AreasController class
#
class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]
  # before_action :check_permissions, only: [ :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /areas
  # GET /areas.json
  def index
    @user = current_user
    @areas = Area.where(company_id: @user.company_id)
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
    @area = Area.find(params[:id])
  end

  # GET /areas/new
  def new
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit; end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(area_params.merge({ company_id: current_user.company_id }))

    respond_to do |format|
      if @area.save
        flash[:success] = t('.success')
        format.html { redirect_to @area }
        format.json { render :show, status: :created, location: @area }
      else
        flash[:danger] = @area.errors.full_messages
        format.html { render :new }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    respond_to do |format|
      if @area.update(area_params)
        flash[:success] = t('.success')
        format.html { redirect_to @area }
        format.json { render :show, status: :ok, location: @area }
      else
        flash[:danger] = @area.errors.full_messages
        format.html { render :edit }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area.destroy
    respond_to do |format|
      flash[:success] = t('.success')
      format.html { redirect_to areas_url }
      format.json { head :no_content }
    end
  end

  # def data_area
  #   @area = Area.find(params[:m_id])
  #   result = @area.team.users.to_a.map do |user|
  #     {
  #       name: user.name,
  #       time: AreaUserStat.new(user, @area).call
  #     }
  #   end
  #   render json: result.present? ? result : [].to_json
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_params
      params.require(:area).permit(:name, :description, :location)
    end

    def check_permissions
      unless @area.user_id == current_user.id
        redirect_to areas_path, flash: { danger: 'Not authorized!' }
      end
    end
end
