Rails.application.routes.draw do
    scope module: :v1, constraints: ApiVersion.new('v1', true) do
      # Movies
      get    '/movies',            to: 'movies#index'
      get    '/movies/dropdown',   to: 'movies#dropdown'
      post   '/movies',            to: 'movies#create'
      get    '/movies/:id',        to: 'movies#show'
      put    '/movies/:id',        to: 'movies#update'
      delete '/movies/:id',        to: 'movies#destroy'

      # Comments
      get    '/movies/:movie_id/comments',     to: 'comments#index'
      post   '/movies/:movie_id/comments',     to: 'comments#create'
      put    '/movies/:movie_id/comments/:id', to: 'comments#update'
      delete '/movies/:movie_id/comments/:id', to: 'comments#destroy'
    end

    # Auth
    post '/auth/login', to: 'authentication#authenticate'
end
