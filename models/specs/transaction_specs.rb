require("minitest/autorun")
require("minitest/rg")

require_relative("../merchant.rb")
require_relative("../transaction.rb")
require_relative("../Category.rb")

class TransactionTest < MiniTest::Test

  def setup
    @tesco = Merchant.new({'name' => 'Tesco'})
    @margiotta = Merchant.new({'name' => 'Margiotta'})
    @amazon = Merchant.new({'name' => 'Amazon'})
    @spoons = Merchant.new({'name' => 'Wetherspoons'})
    @fags = Category.new({'name' => 'fags'})
    @meals_out = Category.new({'name' => 'eating out'})
    @home_food = Category.new({'name' => 'food shopping'})
    @nights_out = Category.new({'name' => 'nights out'})
    @shopping = Category.new({'name' => 'shopping'})
    @buying_fags = Transaction.new({'value' => 750, 'merchant_id' => @margiotta.id, 'Category_id' => @fags.id})
    @buying_beer = Transaction.new({'value' => 10, 'merchant_id' => @spoons.id, 'Category_id' => @nights_out.id})
    @food_shop = Transaction.new({'value' => 4000, 'merchant_id' => @tesco.id, 'Category_id' => @home_food.id})
    @socks = Transaction.new({'value' => 50, 'merchant_id' => @tesco.id, 'Category_id' => @shopping.id})
    # you cant use id here because these objects arent saved!!!!
  end

  def test_transaction_merchant
    assert_equal(@tesco, @food_shop)
  end

  def test_transaction_by_id
    assert_equal('Woo', Transaction.find_by_id(456))
  end

end
