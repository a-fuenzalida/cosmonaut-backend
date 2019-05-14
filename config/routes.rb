Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  scope 'api/v1' do
    get 'me', :to => 'users#me'
    resources :users do
      resources :posts
      resources :likes
      resources :followings
      get 'followers', :to => 'followings#followers'
      resources :comments
    end

    get 'feed', :to => 'posts#feed'
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
