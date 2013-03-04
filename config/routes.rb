Spree::Core::Engine.routes.draw do
  # Add your extension routes here
    resource :checkout, :controller => 'checkout' do
      member do
        get :kiala_confirm
      end
    end
end

