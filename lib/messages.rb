require './lib/board'


class Messages
  def initialize(player_board, comp_board)
    @player_board = player_board
    @comp_board = comp_board
  end


  def welcome
    p 'Welcome to BATTLESHIP!'
    p 'Enter P to play'
    p 'Enter Q to quit'
  end

  def place_cruiser
    p 'I have laid out my cruiser on the grid. You now need to lay out your cruiser. The Cruiser is three units long.'
    @player_board.render(true)
    p 'Enter the squares for the Cruiser (3 spaces):'
  end

  def place_sub
    p 'I have laid out my submarine on the grid. You now need to lay out your submarine. The Submarine is two units long.'
    @player_board.render(true)
    p 'Enter the squares for the Submarine (2 spaces):'
  end



end
