# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  post '/posts/load', to: 'posts#load'
  resources :posts, only: %i[create index], shallow: true do
    resources :likes, only: %i[create]
  end

  post '/ranking/load', to: 'ranking#load'
  resources :ranking, only: %i[index show edit update destroy]

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
