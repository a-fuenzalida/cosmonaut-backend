Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  scope 'api/v1' do
    resources :users do
      resources :posts
      resources :likes
      resources :followings
      get 'followers', :to => 'followings#followers'
      resources :comments
    end

    resources :posts do
      resources :tags
      resources :likes
      resources :comments
    end

    resources :tags do
      resources :posts
    end
  end
end
