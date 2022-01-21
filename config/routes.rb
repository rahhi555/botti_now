# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  resources :posts, only: %i[index delete update]
  post 'user/:user_id/posts', to: 'posts#create', as: 'user_posts'
end
