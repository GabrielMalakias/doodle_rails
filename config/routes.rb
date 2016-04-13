Doodle::Engine.routes.draw do

  resources :users, only: [:index, :create]
  resources :keywords, only: [:index, :create]

  post 'authenticate', to: 'auth#authenticate'


  post '/conversations', to: 'conversations#create'
  #post '/chat/:channel/next', to: 'chat#next'
  get '/chat/:login/has_protocols', to: 'chat#has_protocols?'
  post '/chat/:login/next', to: 'chat#next'

  post '/chat/finalize', to: 'chat#finalize'

  post '/conversations/messages', to: 'conversations#messages'
  post '/messages', to: 'messages#create'

  get '/channels', to: 'channels#index'


end
