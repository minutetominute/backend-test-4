Rails.application.routes.draw do
  scope '/calls' do
    get '', to: 'calls#index'
    post '', to: 'calls#create'
    get 'handle-gather', to: 'calls#handle_gather'
    post 'voicemail', to: 'calls#voicemail'
    post 'status', to: 'calls#update'
  end
end
