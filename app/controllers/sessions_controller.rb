class SessionsController < ApplicationController
  def new
  end

   def create
     teacher = Teacher.find_by(email: params[:session][:email].downcase)

     if teacher && teacher.authenticate(params[:session][:password])
       create_session(teacher)
       flash[:notice] = "Welcome, #{teacher.name}!"
       redirect_to root_path
     else
       flash.now[:alert] = 'Invalid email/password combination'
       render :new
     end
   end

   def destroy
     destroy_session(current_teacher)
     flash[:notice] = "You've been signed out, come back soon!"
     redirect_to root_path
   end
end
