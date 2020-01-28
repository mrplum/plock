class Statics::UsersController < ApplicationController
  def users_table
    render json: User.all
  end

  def user_select
    users = User.all.map{ |u| [u.name, u.id] }
    render json: users
  end

  def index
    @record = 'users'
    render 'statics/index'
  end

  def new
    @model = User.new
    render 'statics/new'
  end

  def edit
    render 'statics/edit'
  end

  def create
  end

  def update
  end

  def destroy
  end
end