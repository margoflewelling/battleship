require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/messages'

message = Messages.new
message.welcome

response = gets.chomp
message.placement
