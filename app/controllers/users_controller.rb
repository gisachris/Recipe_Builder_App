class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
  end

  def show
    return unless params[:id] == 'sign_out'

    sign_out current_user
    redirect_to user_session_path
  end
end
