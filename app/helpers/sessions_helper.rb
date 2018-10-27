module SessionsHelper
  def create_session(teacher)
    session[:user_id] = teacher.id
  end

  def destroy_session(teacher)
    session[:user_id] = nil
  end

  def current_teacher
    Teacher.find_by(id: session[:user_id])
  end
end
