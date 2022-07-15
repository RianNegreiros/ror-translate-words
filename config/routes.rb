Rails.application.routes.draw do
  resources :words, only: %i[index new create]
end
