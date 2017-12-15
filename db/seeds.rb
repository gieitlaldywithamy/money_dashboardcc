require('./models/merchant')
require('./models/tag')
require('./models/transaction')

# Merchants
tesco = Merchant.new({'name' => 'Tesco'})
margiotta = Merchant.new({'name' => 'Margiotta'})
amazon = Merchant.new({'name' => 'Amazon'})
spoons = Merchant.new({'name' => 'Wetherspoons'})

tesco.save()
margiotta.save()
amazon.save()
spoons.save()

# Tags
fags = Tag.new({'name' => 'fags'})
rent = Tag.new({'name' => 'rent'})
ct = Tag.new({'name' => 'council tax'})
meals_out = Tag.new({'name' => 'eating out'})
home_food = Tag.new({'name' => 'food shopping'})

fags.save()
rent.save()
ct.save()
meals_out.save()
home_food.save()

# transactions
buying_fags = Transaction.new({'value' => 750, 'merchant_id' => margiotta.id, 'tag_id' => fags.id})
buying_fags.save()
