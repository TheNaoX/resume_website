TrainessExam::Application.routes.draw do
  devise_for :users
  
  root to: "main#index"

  resources :posts, only: [:index, :show, :new, :create]
end
