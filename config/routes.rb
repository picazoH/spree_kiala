Spree::Core::Engine.routes.draw do

  # non-restful checkout stuff
  get '/checkout/kiala_confirm', :to => 'checkout#kiala_confirm', :as => :kiala_confirm_checkout

  namespace :admin do
    resources :orders, :controller => 'orders' do
        member do
          get :shipment_state_upgrade
        end
    end
  end
end

