Rails.application.routes.draw do
  # devise_for :employees, controllers: {
  #        sessions: 'employees/sessions'
  #      }
  devise_for :employees
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'welcome/index'
  root 'welcome#index'
  resources :leaves
  resources :leave_quota
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
