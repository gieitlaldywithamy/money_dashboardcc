require 'sinatra'
require 'sinatra/contrib/all'

require_relative('./controllers/transaction_controller.rb')
require_relative('./controllers/merchant_controller.rb')
require_relative('./controllers/tag_controller.rb')

require_relative('./models/transaction.rb')
require_relative('./models/tag.rb')
require_relative('./models/merchant.rb')
require_relative('./models/account_settings.rb')

get '/' do
    @account =  AccountSettings.current_account()
    erb(:index)
end
