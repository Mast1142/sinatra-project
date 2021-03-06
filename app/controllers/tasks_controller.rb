class TasksController < ApplicationController
  get '/tasks' do #index
    if logged_in?
      @tasks = Task.all.select do |task|
        task.user_id == current_user.id && task.completed == false
      end
      @completed = Task.all.select do |task|
        task.user_id == current_user.id && task.completed == true
      end
      erb :"tasks/index"
    else
      redirect '/login'
    end
  end

  get '/tasks/new' do #form for new tasks
    if logged_in?
      erb :"tasks/new"
    else
      redirect "/login"
    end
  end

  post '/tasks' do #new tasks
    if params[:content] != ""
      @task = Task.new(params)
      @task.user = current_user
      @task.completed = false
      @task.save
      redirect "/tasks"
    else
      redirect "/tasks/new"
    end
  end

  get '/tasks/:id' do #show
    if logged_in?
      @task = Task.find_by_id(params[:id])
      erb :"tasks/show"
    else
      redirect "/login"
    end
  end

  get '/tasks/:id/edit' do #load form for edit
    if logged_in?
      @task = Task.find_by_id(params[:id])
      if @task && @task.user == current_user
        erb :"tasks/edit"
      end
    else
      redirect "/login"
    end
  end

  patch '/tasks/:id' do #patch edit
    @task = Task.find_by_id(params[:id])
    if params[:content] != ''
      @task.update(content: params[:content])
      redirect "/tasks"
    else
      redirect "/tasks/#{@task.id}/edit"
    end
  end

  delete '/tasks/:id/delete' do #delete
    if logged_in?
      @task = Task.find_by_id(params[:id])
      if @task && @task.user == current_user
        @task.delete
      end
        redirect "/tasks"
    else
      redirect "/login"
    end
  end

  patch '/tasks/:id/completed' do #patch edit
    @task = Task.find_by_id(params[:id])
    if @task && @task.user == current_user
      @task.completed = true
      @task.save
    end
    redirect "/tasks"
  end
end
