# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "home#index"

  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  resources :books, concerns: :paginatable do
    get :import_by_isbn, on: :collection
    post :import_preview, on: :collection
    post :submit_import, on: :collection
  end

  resources :rentals, concerns: :paginatable, except: :show do
    post :return, on: :member
  end

  resources :collections do
    get "page/:page", action: :show, on: :member
  end

  resources :authors do
    get "page/:page", action: :show, on: :member
  end
end
