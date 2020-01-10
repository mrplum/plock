class UsersController < ApplicationController
    before_action :authenticate_user!

    def show
        @user = current_user
        @projects = @user.projects


        # respond_to do |format|
            # format.csv  {
            #     send_data @User.to_csv(), :filename => "data.csv"
            # }

            # format.tsv  {
            #     send_data @User.to_tsv(), :filename => "data.tsv"
            # }
        # end
    end

    def data
        # current_user.tracks.group_by('DATE(created_at)').collect do |date, track|
        #     { letter: date, frequency: track.sum(&:hours)}
        # end.to_json

        render json: [
            {'letter' => "T", "frequency" => 5},
            {'letter' => "R", "frequency" => 4},
            {'letter' => "O", "frequency" => 3},
            {'letter' => "L", "frequency" => 10},
            {'letter' => "A", "frequency" => 7},
            {'letter' => "S", "frequency" => 1},
            {'letter' => "O", "frequency" => 1}
        ].to_json
    end
end
