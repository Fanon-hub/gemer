class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @q = Task.ransack(params[:q])
    @tasks = @q.result(distinct: true)
    
    # Apply sorting if sort parameter is present
    if params[:q] && params[:q][:s]
      @tasks = @tasks.order(params[:q][:s])
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task was successfully destroyed.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :deadline, :priority)
  end
end