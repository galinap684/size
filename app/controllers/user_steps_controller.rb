class UserStepsController < ApplicationController
  include Wicked::Wizard
  steps :personal

  def show
    @user = current_user
    render_wizard
  end

  def update
    @user = current_user
    @user.attributes = allowed_params
    render_wizard @user
  end

  private


  def allowed_params
    params.require(:user).permit(:bust, :waist, :hips, :name)
  end

  def finish_wizard_path
    '/choices'
  end

end
