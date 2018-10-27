module SessionsHelper
  def create_session(user)
    session[:teacher_id] = user.id
  end

  def destroy_session(user)
    session[:teacher_id] = nil
  end

  def current_teacher
    Teacher.find_by(id: session[:teacher_id])
  end
end
