TrainessExam::Application.routes.draw do
  devise_for :users, path_names: { sign_up: "register" }
  
  root to: "main#index"

  resources :posts, only: [:index, :show, :new, :create] do
    collection do
      post :like
      post :unlike
    end
  end
end
