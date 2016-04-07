Doodle::Engine.routes.draw do

  resources :users, only: [:index, :create]
  resources :keywords, only: [:index, :create]

  post 'authenticate', to: 'auth#authenticate'
  get '/chat/:channel/has_protocols', to: 'chat#has_protocols?'

  post '/conversations', to: 'conversations#create'
  post '/chat/:channel/next', to: 'chat#next'

  post '/chat/finalize', to: 'chat#finalize'

#
#  get '/chat', to: 'chat#index'
#  get '/chat/support', to: 'chat#support'
#  post '/chat/finalize', to: 'chat#finalize'
#
#  post '/users/:channel/join', to: 'users#join'
#
#  post '/conversations/messages', to: 'conversations#messages'
#  post '/messages', to: 'messages#create'


end
