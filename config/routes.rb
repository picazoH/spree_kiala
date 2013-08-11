Spree::Core::Engine.routes.draw do
  # Add your extension routes here
    resource :checkout, :controller => 'checkout' do
      member do
        get :kiala_confirm
      end
    end

    namespace :admin do
      resources :orders do
        resources :shipments, :controller => 'shipments' do
          member do
            get :shipment_state_upgrade
          end
        end
      end
    end
end

