require_relative('../models/merchant')
require_relative('../models/tag')
require_relative('../models/transaction')


Transaction.delete_all()
Merchant.delete_all()
Tag.delete_all()
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
nights_out = Tag.new({'name' => 'nights out'})
shopping = Tag.new({'name' => 'shopping'})

fags.save()
rent.save()
ct.save()
meals_out.save()
home_food.save()
nights_out.save()
shopping.save()

# transactions
buying_fags = Transaction.new({'name' => 'Buying cigarettes','value' => 750, 'merchant_id' => margiotta.id, 'tag_id' => fags.id})
buying_beer = Transaction.new({'name' => 'Meal at spoons','value' => 10, 'merchant_id' => spoons.id, 'tag_id' => nights_out.id})
food_shop = Transaction.new({'name' => 'store cupboard','value' => 4000, 'merchant_id' => tesco.id, 'tag_id' => home_food.id})
socks = Transaction.new({'name' => 'new socks','value' => 50, 'merchant_id' => tesco.id, 'tag_id' => shopping.id})
buying_fags.save()
buying_beer.save()
food_shop.save()
socks.save
