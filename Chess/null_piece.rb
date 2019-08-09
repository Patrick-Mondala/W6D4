require_relative "piece.rb"
require "singleton"

class NullPiece < Piece
    include Singleton
    
    def initialize
        @symbol = " "
    end
end