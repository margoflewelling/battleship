require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_it_exits_and_has_attrs
    cruiser = Ship.new("Cruiser", 3)
    assert_instance_of Ship, cruiser
    assert_equal "Cruiser", cruiser.name
    assert_equal 3, cruiser.length
  end

  def test_health
    cruiser = Ship.new("Cruiser", 3)
    assert_equal 3, cruiser.health
  end

  def test_sunk?
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, cruiser.sunk?
## test true
    assert_equal true
  end

  def test_hit
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit
    assert_equal 2, cruiser.health
  end

end

#add another ship to test length and health
