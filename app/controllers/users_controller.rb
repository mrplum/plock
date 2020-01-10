class UsersController < ApplicationController
    before_action :authenticate_user!

    def show
        @user = current_user
        @projects = @user.projects
    end

    respond_to do |format|
        format.csv  { 
            send_data @User.to_csv(), :filename => "data.csv"
        }
        format.tsv  {
            send_data @User.to_tsv(), :filename => "data.tsv"
        }
    end

end
  