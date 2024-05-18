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
    get 'shops/unsubscribe'             => 'shops#unsubscribe', as: 'confirm_unsubscribe'
    patch 'shops/withdraw'              => 'shops#withdraw', as: 'withdraw_shop'
    get 'members/:member_id/pre_orders' => 'pre_orders#index', as: 'member_pre_orders'
    get 'search'                        => 'searches#search'
    get ':id/review'                    => 'review#index', as: 'review'

    resources :members, only: [:show]
    resources :items, except: [:show]
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

    get "members" => redirect("/members/sign_up")
    get 'members/mypage'           => 'members#show', as: 'mypage'
    get 'members/information/edit' => 'members#edit', as: 'edit_information'
    patch 'members/information'    => 'members#update', as: 'update_information'
    get 'members/unsubscribe'      => 'members#unsubscribe', as: 'member_confirm_unsubscribe'
    put 'members/information'      => 'members#update'
    patch 'members/withdraw'       => 'members#withdraw', as: 'withdraw_member'
    post 'pre_orders/confirm'      => 'pre_orders#confirm'
    get 'pre_orders/confirm'       => 'pre_orders#error'
    get 'pre_orders/thanks'        => 'pre_orders#thanks', as: 'thanks'
    get 'bookmarks'                => 'bookmarks#bookmark_list', as: 'bookmarks'
    get 'favorite_shops'           => 'favorite_shops#shop_list', as: 'favorite_shops'
    get 'favorite_shop_items'      => 'favorite_shops#item_list', as: 'favorite_shop_items'
    get 'search'                   => 'searches#search'

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
