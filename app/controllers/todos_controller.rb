class TodosController < ApplicationController

  def index
    @todos = Todo.all.order('id')
  end

  def new
    @todo = Todo.new
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect_to   root_path notice: "Se ha eliminado  el registro"
  end

  def complete
         @todo = Todo.find(params[:id])
         if@todo.update(completed: !@todo.completed)
               redirect_to   root_path, notice: "Se ha actualizado  el registro"
         else
             redirect_to edit_todo_path(@todo), notice: "No se actualizo registro"
         end
  end

  def list
        @todos = Todo.all
        @completado = @todos.select{ |valor|  valor.completed }
        @pendiente =  @todos.select{ |valor| !valor.completed  }
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)
          redirect_to   root_path, notice: "Se ha actualizado  el registro"
    else
        redirect_to edit_todo_path(@todo), notice: "No se actualizo registro"
    end
  end

  def  show
     @todo = Todo.find(params[:id])
  end

  def edit
      @todo = Todo.find(params[:id])
  end

  def create
      todo = Todo.new(todo_params)
      if todo.completed.nil?
         todo.completed = 0
      end

      if todo.save
        redirect_to root_path, notice: "Se ha creado el registro"
      else
        redirect_to root_path, notice: "No se  ha creado el registro"
      end
    end

    private

    def todo_params
      params.require(:todo).permit(:description,:completed)
    end

end
