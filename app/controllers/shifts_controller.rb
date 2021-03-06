class ShiftsController < ApplicationController
  before_action :require_sign_in

  def index
    @teacher = current_teacher
    @shifts = @teacher.shifts
    @new_shift = Shift.new
  end

  def new
    @teacher = current_teacher
    @new_shift = Shift.new
  end

  def create
    if current_teacher.not_working?
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
    else
      flash.now[:alert] = "You are already clocked in!"
      redirect_to teacher_shifts_path(current_teacher)
    end
  end

  def edit
    @shift = Shift.find(params[:id])
    @teacher = current_teacher
  end

  def update
    @shift = Shift.find(params[:id])
    @shift.assign_attributes(shift_params)
    @teacher = current_teacher
    @teacher.not_working

    if @shift.save
      flash[:notice] = "You clocked out at #{Time.now}"
      redirect_to teacher_shifts_path
    else
      flash.now[:alert] = "There was an error clocking out."
      render :edit
    end
  end


  private

  def shift_params
    params.require(:shift).permit(:clock_in, :clock_out, :current)
  end
end
