require_relative "piece"
require_relative "slideable"

class Rook < Piece
    include Slideable
    attr_reader :symbol
    attr_accessor :pos

    def initialize(color, board, pos) 
        super
        @symbol = " ♜ "
    end

    def move_dirs
        horizontal_dirs
    end

end

class Bishop < Piece
    include Slideable
    attr_reader :symbol
    attr_accessor :pos

    def initialize(color, board, pos) 
        super
        @symbol = " ♝ "
    end

    def move_dirs
        diagonal_dirs
    end
end

class Queen < Piece
    include Slideable
    attr_reader :symbol
    attr_accessor :pos

    def initialize(color, board, pos) 
        super
        @symbol = " ♛ "
    end

    def move_dirs
        horizontal_dirs.concat(diagonal_dirs)
    end
end