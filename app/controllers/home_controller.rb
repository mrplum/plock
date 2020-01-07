class HomeController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index], raise: false

end
