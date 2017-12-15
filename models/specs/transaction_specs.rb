require("minitest/autorun")
require("minitest/rg")

require_relative("../merchant.rb")
require_relative("../transaction.rb")
require_relative("../tag.rb")

class TransactionTest < MiniTest::Test

  def setup
    @tesco = Merchant.new({'name' => 'Tesco'})
    @margiotta = Merchant.new({'name' => 'Margiotta'})
    @amazon = Merchant.new({'name' => 'Amazon'})
    @spoons = Merchant.new({'name' => 'Wetherspoons'})
    @fags = Tag.new({'name' => 'fags'})
    @meals_out = Tag.new({'name' => 'eating out'})
    @home_food = Tag.new({'name' => 'food shopping'})
    @nights_out = Tag.new({'name' => 'nights out'})
    @shopping = Tag.new({'name' => 'shopping'})
    @buying_fags = Transaction.new({'value' => 750, 'merchant_id' => @margiotta.id, 'tag_id' => @fags.id})
    @buying_beer = Transaction.new({'value' => 10, 'merchant_id' => @spoons.id, 'tag_id' => @nights_out.id})
    @food_shop = Transaction.new({'value' => 4000, 'merchant_id' => @tesco.id, 'tag_id' => @home_food.id})
    @socks = Transaction.new({'value' => 50, 'merchant_id' => @tesco.id, 'tag_id' => @shopping.id})
    # you cant use id here because these objects arent saved!!!!
  end

  def test_transaction_merchant
    assert_equal(@tesco, @food_shop)
  end

end
