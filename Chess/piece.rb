require "colorize"

class Piece
    attr_accessor :pos
    attr_reader :board, :color, :symbol

    def initialize(color, board, pos) 
        @color = color
        @board = board
        @pos = pos
    end

    def to_s
        self.symbol.to_s.colorize(self.color)
    end

end