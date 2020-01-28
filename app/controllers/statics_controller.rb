class StaticsController < ApplicationController
  layout 'admin'
  
  def dashboard
  end

  def models_count
    companies = Company.count
    intervals = Interval.count
    tracks    = Track.count
    users     = User.count
    projects  = Project.count
    teams     = Team.count
    render json: {companies: companies, intervals: intervals, tracks: tracks,
                  users: users, projects: projects, teams: teams}
  end

  def index
  end

  def new
    @model = Company.new
  end
end