require_relative('../models/merchant')
require_relative('../models/category')
require_relative('../models/transaction')
require_relative('../models/user')


# Transaction.delete_all()
Category.delete_all()
User.delete_all()

user1 = User.new('name' => 'Amy','annual_income' => 18000, 'password' => 'amyspassword')
user1.save()
user2 = User.new('name' => 'Eleanor','annual_income' => 24000, 'password' => 'elliespassword')
user2.save()

essential_categories = ['rent', 'electricity bill', 'gas bill', 'phone bill', 'gym membership', 'groceries']

essential_categories.each do |category|
  Category.new({"name" => category, "luxury" => false}).save()
end
luxury_categories = ['eating out', 'coffee', 'alcohol', 'socialising', 'presents', 'credit card bill', 'shopping', 'travel', 'lazy travelling']
# Categorys
luxury_categories.each do |category|
  Category.new({"name" => category, "luxury" => true}).save()
end


# # Merchants
# landlord = Merchant.new({'name' => 'Landlord'})
# scottish_gas = Merchant.new({'name' => 'Scottish Gas'})
# edinburgh_council = Merchant.new({'name' => 'Edinburgh Council'})
# tesco = Merchant.new({'name' => 'Tesco'})
# margiotta = Merchant.new({'name' => 'Margiotta'})
# nationwide = Merchant.new({'name' => 'Nationwide'})
# amazon = Merchant.new({'name' => 'Amazon'})
# asos = Merchant.new({'name' => 'Asos'})
# henrys = Merchant.new({'name' => 'Henrys Cellar Bar'})
# scotrail = Merchant.new({'name' => 'Scotrail'})
#
# landlord.save()
# scottish_gas.save()
# edinburgh_council.save()
# tesco.save()
# margiotta.save()
# nationwide.save()
# amazon.save()
# asos.save()
# henrys.save()
# scotrail.save()



# # transactions
# weekly_shop = Transaction.new(
#   {'name' => 'Weekly food shop',
#     'value' => 40.00,
#     'merchant_id' => tesco.id,
#
#     'transaction_date' => "2017-12-19",
#     'Category_id' => food_shop.id,
#     'account_id' => user1.id})
#
# loud_poets = Transaction.new({
#   'name' => 'Loud poets',
#   'value' => 12.00,
#   'transaction_date' => "2017/12/19",
#   'merchant_id' => henrys.id,
#   'Category_id' => nights_out.id,
#   'account_id' => user1.id
# })
#
# rent = Transaction.new({
#   'name' => 'Rent',
#   'value' => 400.00,
#   'transaction_date' => "2017/12/19",
#   'merchant_id' => landlord.id,
#   'Category_id' => rent.id,
#   'account_id' => user1.id
# })
#
# council_tax = Transaction.new({
#   'name' => 'Council tax',
#   'value' => 50.00,
#   'transaction_date' => "2017/12/19",
#   'merchant_id' => edinburgh_council.id,
#   'Category_id' => council_tax.id,
#   'account_id' => user1.id
# })
#
# travel = Transaction.new({
#   'name' => 'Stirling trip',
#   'value' => 20.50,
#   'transaction_date' => "2017/12/19",
#   'merchant_id' => scotrail.id,
#   'Category_id' => travel.id,
#   'account_id' => user2.id
# })
#
# weekly_shop.save()
# loud_poets.save()
# rent.save()
# council_tax.save()
# travel.save()
 # how to make save option with date
