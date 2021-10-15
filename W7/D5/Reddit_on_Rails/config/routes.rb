Rails.application.routes.draw do
  resources :users
  resource :session
  resources :subs do 
    resources :posts, except: [:index]
  end

  root to: redirect('/subs')
end
