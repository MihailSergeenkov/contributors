Rails.application.routes.draw do
  root 'search#new'
  resource :search, only: [:new, :show, :create], controller: 'search' do
    resources :contributors, shallow: true, only: [:index, :show]
  end
end
