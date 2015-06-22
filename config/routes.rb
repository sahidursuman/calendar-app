CalendarApp::Application.routes.draw do
	scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do 
	  root "pages#home"
	  get "home", to: "pages#home", as: "home"
	  get "inside", to: "pages#inside", as: "inside"
	  get "posts", to: "pages#posts", as: "posts"
	  get "posts/:id", to: "pages#show_post", as: "post"
	  devise_for :users, :path_prefix => 'my'

	  resources :users, only: [:index, :show]

	  resources :instructors do
	    resources :bookings
	    resources :availabilities
	    resources :reviews
	  end
	  namespace :admin do
	    root "base#index"
	    resources :users
	    get "posts/drafts", to: "posts#drafts", as: "posts_drafts"
	    get "posts/dashboard", to: "posts#dashboard", as: "posts_dashboard"
	    resources :posts
	  end
	end
	# match '*path', to: redirect("/#{I18n.default_locale}/%{path}"), via: [:get, :post]
	# match '', to: redirect("/#{I18n.default_locale}/%{path}"), via: [:get, :post]
	get '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }
	get '', to: redirect("/#{I18n.default_locale}")
end
