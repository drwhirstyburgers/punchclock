class ShiftsController < ApplicationController
  def index
    @teacher = current_teacher
    @shifts = @teacher.shifts
  end

  def new
    @teacher = current_teacher
    @new_shift = Shift.new
  end

  def create
    @shift = current_teacher.shifts.new(shift_params)
    @teacher = current_teacher
    @teacher.update_working

    if @shift.save
      flash[:notice] = "You have clocked in at #{Time.now}"
      redirect_to teacher_shifts_path(current_teacher)
    else
      flash.now[:alert] = "There was an error. Please try again."
      render :new
    end
  end

  def edit
    @shift = current_teacher.shifts.find(params[:id])
  end

  private

  def shift_params
    params.require(:shift).permit(:clock_in)
  end
end
