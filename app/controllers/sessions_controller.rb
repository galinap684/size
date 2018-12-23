class SessionsController < ApplicationController
  def new
end

def create
 user = User.find_by(email: params[:email])
 # If the user exists AND the password entered is correct.
 if user && user.authenticate(params[:password])
   # Save the user id inside the browser cookie. This is how we keep the user
   # logged in when they navigate around our website.
   session[:user_id] = user.id
   redirect_to root_url, notice: "Logged in!"
 else
 # If user's login doesn't work, send them back to the login form.
 #flash.now.notice = "Email or password is invalid"
 flash
   redirect_to login_path, danger: "Invalid email or password"
 end
end

def destroy
   session[:user_id] = nil
  redirect_to root_url, notice: "Logged out!"
 end


end
