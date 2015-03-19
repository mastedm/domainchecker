DomainChecker::Application.routes.draw do
  root "domains#index"
  
  resources :domains do 
    collection do 
      post "create_bunch"
    end
  end
end
