Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'welcome/index'
  root 'welcome#index'
  resources :leaves
  resources :leave_quota
  devise_for :employees, :skip => [:registrations] 
    as :employee do
    get 'employees/edit' => 'devise/registrations#edit', :as => 'edit_employee_registration'
    put 'employees' => 'devise/registrations#update', :as => 'employee_registration'
  end
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
