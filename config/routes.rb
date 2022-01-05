# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  resources :posts, only: %i[index create delete update]
end
