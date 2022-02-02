# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  resources :posts, only: %i[create index delete update], shallow: true do
    resources :likes, only: %i[create delete]
  end
end
