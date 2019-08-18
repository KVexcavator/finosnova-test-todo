Rails.application.routes.draw do
  post 'signup', controller: :signup, action: :create
  post 'signin', controller: :signin, action: :create
  post 'signin', controller: :signin, action: :reset
  delete 'signin', controller: :signin, action: :destroy

  resources :todos
end
