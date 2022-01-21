Rails.application.routes.draw do
  get 'qr_codes/convert'
  post 'qr_codes/export'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
