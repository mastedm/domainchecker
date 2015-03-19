DomainChecker::Application.routes.draw do
  resources :domains do 
    collection do 
      post "create_bunch"
    end
  end
end
