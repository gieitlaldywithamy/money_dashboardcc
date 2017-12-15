require('./models/merchant')

tesco = Merchant.new({'name' => 'Tesco'})
margiotta = Merchant.new({'name' => 'Tesco'})
amazon = Merchant.new({'name' => 'Amazon'})
spoons = Merchant.new({'name' => 'Wetherspoons'})

tesco.save()
margiotta.save()
amazon.save()
spoons.save()
#  = Merchant.new({'Tesco'})
# tesco = Merchant.new({'Tesco'})
# tesco = Merchant.new({'Tesco'})
