Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, 	 :controllers => { :registrations => 'users/registrations', :sessions =>'users/sessions' }
  root "home#index"
  get 'home' => 'home#index'

  get '/notification' => 'home#notification', as: :notice
  delete '/notification/:id' => 'notification#destroy', as: :notification
  delete '/delete_all_notification/:id' => 'notification#delete_all', as: :delete_all

  resources :home, only: [:delete_notice] do
    collection do
      delete :delete_notice
    end
  end

  get 'admin/teamlead' => 'admin#teamlead'
  get 'admin/developers' => 'admin#developer'
  get 'admin/tester' => 'admin#tester'
  get 'admin/make_tt/:id' => 'admin#make_tt', as: :make_tt
  get 'admin/make_dp/:id' => 'admin#make_dp', as: :make_dp
  get 'assign_employee/:id' =>'admin#assign_employee', as: :assign_employee
   get 'admin/showa/:id' =>  'requirement#showa', as: :showa

  get 'teamlead/tester' => 'teamlead#tester'
  get 'teamlead/developers' => 'teamlead#developer'

  get 'make_task_tl/:id' => 'teamlead#make_task_tl', as: :make_task_tl

  resources :requirement
  patch 'admin/make_teamlead/:id' => 'admin#make_teamlead', as: :make_teamlead
  delete 'admin/employee/:id' => 'employee#destroy',        as: :admin_employee

  resources :task
  patch 'close_task/:id' => 'task#close_task', as: :close_task
  patch 'reopen_task/:id' => 'task#reopen_task', as: :reopen_task



  resources :teamlead, only: [:tl_assign_to_multiple] do
    collection do
      put :tl_assign_to_multiple
      put :tl_assign
    end
  end

  resources :admin, only: [:edit_project_multiple, :update_project_multiple] do
    collection do
      get :edit_project_multiple, as: :edit_project_multiple
      put :update_project_multiple, as: :update_project_multiple
      put :assign_employee_put,     as: :assign_employee_put
    end
  end

  resources :developer, only: [:done_multiple_update] do
    collection do
      put :done_multiple_update, as: :done_multiple_update
    end
  end

  resources :tester, only: [:done_multiple_update] do
    collection do
      put :done_multiple_update, as: :done_multiple_update
    end
  end

  

  get 'add_task/:id' => 'teamlead#add_task', as: :add_task
  
end
