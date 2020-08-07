class Stadistics::UsersController < ApplicationController
  def users_table
    render json: User.all
  end

  def user_select
    users = User.all.map{ |u| [u.name, u.id] }
    render json: users
  end

  def index
    @record = 'users'
    render 'stadistics/index'
  end

  def new
    @model = User.new
    render 'stadistics/new'
  end

  def edit
    render 'stadistics/edit'
  end

  def create
  end

  def update
  end

  def destroy
  end
end