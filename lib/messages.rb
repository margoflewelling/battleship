require './lib/board'


class Messages
  def initialize

  end


  def welcome
    p 'Welcome to BATTLESHIP!'
    p 'Enter P to play'
    p 'Enter Q to quit'
  end

  def placement
    @board = Board.new
    p 'I have laid out my ships on the grid. You now need to lay out your two ships. The Cruiser is three units long and the Submarine is two units long.'
    @board.render
    p 'Enter the squares for the Cruiser (3 spaces):'
  end

end
