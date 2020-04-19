# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "home#index"

  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  resources :books, concerns: :paginatable

  resources :collections do
    get "page/:page", action: :show, on: :member
  end

  resources :authors do
    get "page/:page", action: :show, on: :member
  end
end
