class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  #read data
  get '/recipes' do
    Recipe.find_or_create_by(name: "Fried Rice", ingredients: "Rice, Meat, Vegetables, Oil", cook_time: 10)
    erb :index
  end

  #
  #create new recipe
  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.find_or_create_by(name: params["name"], ingredients: params["ingredients"], cook_time: params["cook_time"])
    redirect "/recipes/#{@recipe.id}"
  end

  #
  #update existing recipe
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_or_create_by(params[:id])
    @recipe.update(name: params["name"], ingredients: params["ingredients"], cook_time: params["cook_time"])
    erb :show
  end

  #
  #delete recipe

  delete '/recipes/:id' do
    Recipe.find(params[:id]).delete
    redirect "/recipes"
  end

  #wildcard--show
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])

    erb :show
  end

end
