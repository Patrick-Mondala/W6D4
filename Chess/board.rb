require_relative "knight_king.rb"
require_relative "rook_bishop_queen.rb"
require_relative "pawn.rb"
require_relative "null_piece.rb"

class Board
    attr_reader :sentinel, :winner
    attr_accessor :rows
    def initialize
        @sentinel = NullPiece.instance
        @rows = Array.new(8) { Array.new(8, @sentinel) }
        @black_pieces = []
        @white_pieces = []
        populate_board
        @winner = ""
    end

    def [](pos)
        self.rows[pos.first][pos.last]
    end

    def []=(pos, value)
        self.rows[pos.first][pos.last] = value
    end

    def move_piece(color, start_pos, end_pos)
        raise "start position out of bounds" unless start_pos.first >= 0 && start_pos.first <= 7 && start_pos.last >= 0 && start_pos.last <= 7
        starting_piece = self[start_pos]
        raise "there was no piece there" if starting_piece == @sentinel
        raise "piece can not move there" unless starting_piece.valid_moves.include?(end_pos)
        raise "it's #{color == :white ? :white : :black}'s turn" unless color == starting_piece.color
        move_piece!(color, start_pos, end_pos)
    end

    def remove_piece(color, pos)
        if color == :white 
            @white_pieces.delete(self[pos])
        else
            @black_pieces.delete(self[pos])
        end
    end

    #[6] pry(main)> b.move_piece(:white, [6,4],[5,4])
# => [5, 4]
# [7] pry(main)> b.move_piece(:white, [7,3],[3,7])
# => [3, 7]
# [8] pry(main)> b.move_piece(:white, [3,7],[1,7])

    def move_piece!(color, start_pos, end_pos)
        starting_piece = self[start_pos]
        opponent_color = color == :white ? :black : :white
        remove_piece(opponent_color, end_pos) unless self[end_pos] == @sentinel
        self[end_pos] = starting_piece
        self[start_pos] = @sentinel
        checkmate?(opponent_color)
        starting_piece.pos = end_pos
    end

    def checkmate?(color)
        return false unless in_check?(color)
        current_pieces = living_pieces_by_color(color)
        if current_pieces.all? {|piece| piece.valid_moves.empty? }
            @winner = color == :white ? "black" : "white"
            return true
        end
        false
    end

    def in_check?(color)
        king_pos = find_king(color).pos
        opponent_color = color == :white ? :black : :white
        opponent_pieces = living_pieces_by_color(opponent_color)
        opponent_pieces.any? {|piece| piece.moves.include?(king_pos)}
    end

    def living_pieces_by_color(color)
        color == :white ? @white_pieces : @black_pieces
    end

    def find_king(color)
        living_pieces_by_color(color).find {|piece| piece.is_a?(King)}
    end

    def populate_board
        place_kings
        place_queens
        place_bishops
        place_knights
        place_rooks
        place_pawns
    end

    private 
    def place_kings
        black_king_position = [0, 4]
        black_king = King.new(:black, self, black_king_position)
        self[black_king_position] = black_king
        @black_pieces << black_king
        white_king_position = [7, 4]
        white_king = King.new(:white, self, white_king_position)
        self[white_king_position] = white_king
        @white_pieces << white_king
    end

    def place_queens
        black_queen_position = [0, 3]
        black_queen = Queen.new(:black, self, black_queen_position)
        self[black_queen_position] = black_queen
        @black_pieces << black_queen
        white_queen_position =  [7, 3]
        white_queen = Queen.new(:white, self, white_queen_position)
        self[white_queen_position] = white_queen
        @white_pieces << white_queen
    end

    def place_rooks
        black_rook_positions = [[0, 0], [0, 7]]
        black_rook_positions.each do |position| 
            black_rook = Rook.new(:black, self, position)
            self[position] = black_rook
            @black_pieces << black_rook
        end
        white_rook_positions = [[7, 0], [7, 7]]
        white_rook_positions.each do |position| 
            white_rook = Rook.new(:white, self, position)
            self[position] = white_rook
            @white_pieces << white_rook
        end
    end

    def place_bishops
        black_bishops_positions = [[0, 2], [0, 5]]
        black_bishops_positions.each do |position| 
            black_bishop = Bishop.new(:black, self, position) 
            self[position] = black_bishop
            @black_pieces << black_bishop
        end
        white_bishops_positions = [[7, 2], [7, 5]]
        white_bishops_positions.each do |position| 
            white_bishop = Bishop.new(:white, self, position) 
            self[position] = white_bishop
            @white_pieces << white_bishop
        end
    end

    def place_knights
        black_knights_positions = [[0, 1], [0, 6]]
        black_knights_positions.each do |position| 
            black_knight = Knight.new(:black, self, position)
            self[position] = black_knight
            @black_pieces << black_knight
        end
        white_knights_positions = [[7, 1], [7, 6]]
        white_knights_positions.each do |position| 
            white_knight = Knight.new(:white, self, position) 
            self[position] = white_knight
            @white_pieces << white_knight
        end
    end

    def place_pawns
        (0..7).each do |col| 
            black_pawn = Pawn.new(:black, self, [1, col])
            self.rows[1][col] = black_pawn
            @black_pieces << black_pawn
        end

        (0..7).each do |col| 
            white_pawn = Pawn.new(:white, self, [6, col])
            self.rows[6][col] = white_pawn
            @white_pieces << white_pawn
        end
    end
end