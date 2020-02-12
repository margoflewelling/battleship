require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/messages'
require './play'


@game = PlayGame.new(@comp_board, @player_board, @message, @comp_cruiser, @comp_sub, @player_cruiser, @player_sub)
@game.setup

@game.ask_to_play
