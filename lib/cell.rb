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
     if ship == nil
      true
     else
      false
     end
  end

   def place_ship(ship)
     @ships = ship
   end


   def fired_upon?
     @has_been_fired_upon
   end


    def fire_upon
      if empty? == false
        ship.hit
      end
      @has_been_fired_upon = true
    end

    def render(reveal = false)
      @reveal = reveal
      if fired_upon? == false
          if reveal == false
            "."
          elsif reveal == true && empty? == false
            "S"
          end
      else
         if empty? == true
            "M"
         elsif ship.sunk? == true
             "X"
         else
             "H"
         end
      end
    end

end
