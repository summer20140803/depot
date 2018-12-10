Rails.application.routes.draw do
  # as选项会创建 store_index_path 和 store_index_url 具名辅助方法。其中，store_index_path 辅助方法的返回值是 '/'。
  root 'store#index', as: 'store_index'

  resources :line_items do
    # 为line_items控制器添加新的路由方法——decrease_quantity
    member do
      post "decrease_quantity"=>"line_items#decrease_quantity",as:"decrease_quantity"
    end
  end
  resources :carts
  resources :products

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
