Doodle::Engine.routes.draw do

  resources :users, only: [:index, :create]
  resources :keywords, only: [:index, :create]

  post 'authenticate', to: 'auth#authenticate'
  get '/chat/:channel/has_protocols', to: 'chat#has_protocols?'

  post '/conversations', to: 'conversations#create'
  post '/chat/:channel/next', to: 'chat#next'

  post '/chat/finalize', to: 'chat#finalize'

  post '/conversations/messages', to: 'conversations#messages'
  post '/messages', to: 'messages#create'

  get '/channels', to: 'channels#index'


end
