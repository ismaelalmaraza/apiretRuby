Rails.application.routes.draw do
  resources :beers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'auth/login', to: 'authentication#login'
  
  get 'beers/abv/:abv', to: 'beers#getABeerByAbv'
  
  get 'beers/name/:name', to: 'beers#getABeerBynName'

  get 'beers/beer/:id', to: 'beers#getABeer'

  get 'beers/', to: 'beers#getAllBears'

  get 'mybeers', to: 'beers#getMyBeers'

  put 'mybeers/favorite/:id', to: 'beers#update'

  get 'mybeers/favorite', to: 'beers#getMyFavoriteBeer'

end
