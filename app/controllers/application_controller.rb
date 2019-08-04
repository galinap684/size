class ApplicationController < ActionController::Base

protect_from_forgery with: :exception
add_flash_types :danger, :info, :warning, :success

  def execute_statement(sql)
    results = ActiveRecord::Base.connection.exec_query(sql)

    if results.present?
      return results
    else
      return nil
    end
  end


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
    helper_method :current_user

    def authorize
      redirect_to root_url unless current_user
  #flash[:notice] = 'Please log in first!'
    end







end
