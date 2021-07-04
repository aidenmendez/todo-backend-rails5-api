class TodosController < ApplicationController

  def index
    render :json => Todo.all
  end

  def create
    todo = Todo.create(todo_params)
    todo.url = todo_url todo
    todo.save
    render :json => todo
  end

  def show
    render :json => Todo.find( id: params[:id])
  end

  def update
    todo = Todo.find( id: params[:id])
    todo.update_attributes(todo_params)
    render :json => todo
  end

  def destroy_all
    Todo.destroy_all
  end

  def destroy
    todo = Todo.find( id: params[:id])
    todo.destroy
    render :json => {}
  end

  def today
    due_today = Todo.where(due_date: Date.today, completed: false)
    render :json => due_today
  end

  def future
    due_later = Todo.where(:due_date.gt => Date.today, completed: false)
    render :json => due_later
  end

  def all_today
    todays_tasks = Todo.where(:due_date => Date.today)
    render :json => todays_tasks
  end

  private

  def todo_params
    params.permit(:title, :completed, :order, :due_date)
  end

end