class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    @todos = Todo.all
    @switch = 0
    if @switch == 1
      # return finished list
      render json: @todos.as_json(only: [:finished => true])
    elsif @switch == -1
      render json: @todos.as_json(only: [:finished => false])
    else
      render json: @todos
    end
  end

  # GET /todos/1
  def show
    render json: @todo
  end

  # POST /todos
  def create
    @todo = Todo.create(todo_params)
    @todo.save!
    render json: @todo, status: :created, location: @todo
  end

  # PUT /todos/1
  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :body, :finished, :user_id)
  end
end
