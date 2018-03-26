Rails.application.routes.draw do
  get '/thoughts', to: 'thoughts#show' 
  patch '/thoughts', to: 'thoughts#update' 
  post '/refresh_token/:client_id', to: 'token#refresh_token'
end
