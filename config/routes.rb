Rails.application.routes.draw do
  root 'quiz#index'
  get 'quiz', to: 'quiz#index'
  post 'quiz', to: 'quiz#task'
end
