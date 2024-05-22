Rails.application.routes.draw do

# 管理者用(admin)
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'top'    =>  'homes#top', as: 'top'
    get 'search' => 'searches#search'

    resources :shops, only: [:show, :index, :edit, :update]
    resources :members, only: [:show, :index, :edit, :update]
    resources :reviews, only: [:index, :update]
    resources :tags, only: [:index, :create, :update, :destroy]
  end


# ショップ用(shop)
  devise_for :shop, controllers: {
    registrations: "shop/registrations",
    sessions: 'shop/sessions'
  }

# 新規登録失敗後にリロードした際のルート設定とゲストログイン用
  devise_scope :shop do
    get 'shop', to: 'shop/registrations#new', as: 'shop_registrations'
    post 'shop/guest_sign_in', to: 'shop/sessions#guest_sign_in'
  end

  namespace :shop do
    get 'top' => 'homes#top', as: 'top'

    get 'shops/information/edit'        => 'shops#edit', as: 'edit_information'
    patch 'shops/information'           => 'shops#update', as: 'update_information'
    get 'shops/unsubscribe'             => 'shops#unsubscribe', as: 'confirm_unsubscribe'
    patch 'shops/withdraw'              => 'shops#withdraw', as: 'withdraw_shop'
    get 'members/:member_id/pre_orders' => 'pre_orders#index', as: 'member_pre_orders'
    get 'search'                        => 'searches#search'
    #確認して消す get ':member_id/review'             => 'reviews#index', as: 'review'

    resources :members, only: [:show]
    resources :items, except: [:show]
    resources :pre_orders, only: [:show, :index, :update]
  end


# 顧客用(public)
  devise_for :members, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # ゲストログイン用
  devise_scope :member do
    post 'members/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root 'homes#top'
    get 'about' => 'homes#about', as: 'about'

    get "members" => redirect("/members/sign_up")
    get 'members/mypage'           => 'members#show', as: 'mypage'
    get 'members/information/edit' => 'members#edit', as: 'edit_information'
    patch 'members/information'    => 'members#update', as: 'update_information'
    get 'members/unsubscribe'      => 'members#unsubscribe', as: 'member_confirm_unsubscribe'
    put 'members/information'      => 'members#update'
    patch 'members/withdraw'       => 'members#withdraw', as: 'withdraw_member'
    post 'pre_orders/confirm'      => 'pre_orders#confirm'
    get 'pre_orders/confirm'       => 'pre_orders#error'
    post 'pre_orders/thanks'        => 'pre_orders#thanks', as: 'thanks'
    get 'bookmarks'                => 'bookmarks#bookmark_list', as: 'bookmarks'
    get 'favorite_shops'           => 'favorite_shops#shop_list', as: 'favorite_shops'
    get 'favorite_shop_items'      => 'favorite_shops#item_list', as: 'favorite_shop_items'
    get 'search'                   => 'searches#search'
    get ':shop_id/review'          => 'reviews#index', as: 'review'

    resources :shops, only: [:show] do
      resource :favorite_shop, only: [:create, :destroy]
    end

    resources :items, only: [:show] do
      resource :bookmarks, only: [:create, :destroy]
    end

    resources :pre_orders, only: [:new, :show, :index, :create] do
      resource :reviews, only: [:create]
    end
  end
end
