class Admins::ApplicationController < ActionController::Base
  before_action :authenticate_admin!
  layout 'admins'
end
