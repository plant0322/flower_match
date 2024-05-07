Rails.application.routes.draw do

# 管理者用(admin)
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'top' =>  'homes#top', as: 'top'

    resources :shops, only: [:show, :index, :edit, :update]
    resources :members, only: [:show, :index, :edit, :update]
  end


# ショップ用(shop)
  devise_for :shop, controllers: {
    registrations: "shop/registrations",
    sessions: 'shop/sessions'
  }

  namespace :shop do
    get 'top' =>  'homes#top', as: 'top'

    get 'shops/information/edit'        => 'shops#edit', as: 'edit_information'
    patch 'shops/information'           => 'shops#update', as: 'update_information'
    get 'shops/unsubscribe'             => 'shops#unsubscribe', as: 'confirm_unsubscribe_shop'
    patch 'shops/withdraw'                => 'shops#withdraw', as: 'withdraw_shop'
    get 'members/:member_id/pre_orders' => 'pre_orders#index', as: 'member_pre_orders'

    resources :members, only: [:show]
    resources :items
    resources :pre_orders, only: [:show, :index, :update]
  end


# 顧客用(public)
  devise_for :members, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root 'homes#top'
    get 'about' => 'homes#about', as: 'about'

    get 'members/mypage'           => 'members#show', as: 'mypage'
    get 'members/information/edit' => 'members#edit', as: 'edit_information'
    patch 'members/information'    => 'members#update', as: 'update_information'
    get 'members/unsubscribe'      => 'members#unsubscribe', as: 'confirm_unsubscribe_member'
    put 'members/information'      => 'members#update'
    patch 'members/withdraw'       => 'members#withdraw', as: 'withdraw_member'
    post 'pre_orders/confirm'      => 'pre_orders#confirm'
    get 'pre_orders/confirm'       => 'pre_orders#error'
    get 'pre_orders/thanks'        => 'pre_orders#thanks', as: 'thanks'

    resources :shops, only: [:show]
    resources :items, only: [:show]
    resources :pre_orders, only: [:new, :show, :index, :create]
  end
end
