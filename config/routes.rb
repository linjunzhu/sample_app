SampleApp::Application.routes.draw do
  # 这里的资源有controller就可以了，不需要model

  # 因为这两个页面都是用来显示数据的，所以我们使用了 get 方法，指定这两个地址响应的是 GET 请求。（符合 REST 架构对这种页面的要求）。
  # 路由设置中使用的 member 方法作用是，设置这两个动作对应的 URL 地址中应该包含用户的 id
  resources :users do
    member do
      get :following, :followers    # 访问这个url就会自动去查出来数据了？这里也不是很明白，要看下----------------------------
    end
  end
  # 还可以使用 collection 方法，但 URL 中就没有用户 id 了，所以，如下的代码
  # resources :users do
  #   collection do
  #     get :tigers
  #   end
  # end

  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  root to: 'static_pages#home'

  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/home',   to: 'static_pages#home',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
