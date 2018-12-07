Rails.application.routes.draw do
  # as选项会创建 store_index_path 和 store_index_url 具名辅助方法。其中，store_index_path 辅助方法的返回值是 '/'。
  root 'store#index', as: 'store_index'

  resources :line_items
  resources :carts
  resources :products

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
