Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'games#home'
  get 'game', to: 'games#game'
  post 'answer', to: 'games#answer'

end
