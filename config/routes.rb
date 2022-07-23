Rails.application.routes.draw do
  root "lists#top"
  resources :lists
end
