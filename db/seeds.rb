require_relative('../models/merchant')
require_relative('../models/tag')
require_relative('../models/transaction')
require_relative('../models/user')


Transaction.delete_all()
Merchant.delete_all()
Tag.delete_all()
User.delete_all()

user1 = User.new('name' => 'Amy','budget_limit' => 1800)
user1.save()
user2 = User.new('name' => 'Eleanor','budget_limit' => 800)
user2.save()

# Tags
rent = Tag.new({'name' => 'Rent'})
bills = Tag.new({'name' => 'Bills'})
council_tax = Tag.new({'name' => 'Council Tax'})
eating_out = Tag.new({'name' => 'Eating out'})
credit_card = Tag.new({'name' => 'Credit Card'})
entertainment = Tag.new({'name' => 'Entertainment'})
nights_out = Tag.new({'name' => 'Nights out'})
food_shop = Tag.new({'name' => 'Food shop'})
online_shopping = Tag.new({'name' => 'Online shopping'})
travel = Tag.new({'name' => 'Travel'})

rent.save()
bills.save()
council_tax.save()
eating_out.save()
credit_card.save()
entertainment.save()
nights_out.save()
food_shop.save()
online_shopping.save()
travel.save()

# Merchants
landlord = Merchant.new({'name' => 'Landlord'})
scottish_gas = Merchant.new({'name' => 'Scottish Gas'})
edinburgh_council = Merchant.new({'name' => 'Edinburgh Council'})
tesco = Merchant.new({'name' => 'Tesco'})
margiotta = Merchant.new({'name' => 'Margiotta'})
nationwide = Merchant.new({'name' => 'Nationwide'})
amazon = Merchant.new({'name' => 'Amazon'})
asos = Merchant.new({'name' => 'Asos'})
henrys = Merchant.new({'name' => 'Henrys Cellar Bar'})
scotrail = Merchant.new({'name' => 'Scotrail'})

landlord.save()
scottish_gas.save()
edinburgh_council.save()
tesco.save()
margiotta.save()
nationwide.save()
amazon.save()
asos.save()
henrys.save()
scotrail.save()



# transactions
weekly_shop = Transaction.new(
  {'name' => 'Weekly food shop',
    'value' => 40.00,
    'merchant_id' => tesco.id,

    'transaction_date' => "2017-12-19",
    'tag_id' => food_shop.id,
    'account_id' => user1.id})

loud_poets = Transaction.new({
  'name' => 'Loud poets',
  'value' => 12.00,
  'transaction_date' => "2017/12/19",
  'merchant_id' => henrys.id,
  'tag_id' => nights_out.id,
  'account_id' => user1.id
})

rent = Transaction.new({
  'name' => 'Rent',
  'value' => 400.00,
  'transaction_date' => "2017/12/19",
  'merchant_id' => landlord.id,
  'tag_id' => rent.id,
  'account_id' => user1.id
})

council_tax = Transaction.new({
  'name' => 'Council tax',
  'value' => 50.00,
  'transaction_date' => "2017/12/19",
  'merchant_id' => edinburgh_council.id,
  'tag_id' => council_tax.id,
  'account_id' => user1.id
})

travel = Transaction.new({
  'name' => 'Stirling trip',
  'value' => 20.50,
  'transaction_date' => "2017/12/19",
  'merchant_id' => scotrail.id,
  'tag_id' => travel.id,
  'account_id' => user2.id
})

weekly_shop.save()
loud_poets.save()
rent.save()
council_tax.save()
travel.save()
 # how to make save option with date
