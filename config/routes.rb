Rails.application.routes.draw do
  root 'words#index'

  resources :words, only: %i[index show new create edit update]
end
