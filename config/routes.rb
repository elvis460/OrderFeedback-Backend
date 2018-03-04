Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders do
    member do
      post :feedbacks, to: 'orders#create_feedbacks' 
      get :feedbacks, to: 'orders#show_feedbacks'
    end
  end
end