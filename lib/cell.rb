class Cell
  attr_reader :coordinate
  attr_accessor :reveal

  def initialize(coordinate)
    @coordinate = coordinate
    @has_been_fired_upon = false
  end

  def ship
    @ships
  end

  def empty?
    ship == nil
  end

  def place_ship(ship)
    @ships = ship
  end


  def fired_upon?
    @has_been_fired_upon
  end


  def fire_upon
    ship.hit if empty? == false
    @has_been_fired_upon = true
  end


  def render(reveal = false)
    @reveal = reveal
    return "S" if reveal && !fired_upon? && !empty?
    return "." if fired_upon? == false
    return "M" if empty? == true
    return "X" if ship.sunk? == true
    return "H"
  end

end
