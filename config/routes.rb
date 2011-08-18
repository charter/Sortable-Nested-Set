SortableNestedSet::Application.routes.draw do
  root :to => "pages#index"

  resources :pages do 
    member{
      get   :up
      get   :down
    }
    collection{
      get   :native
      post  :restructure
    }
  end
end
