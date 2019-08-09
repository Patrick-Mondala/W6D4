
class Pawn < Piece
    attr_reader :symbol
    attr_accessor :pos

    def initialize(color, board, pos) 
        super
        @symbol = "♟"
    end

    def move_dirs
        dirs = [
            [2, 0],
            [1, 0],
            [1, 1],
            [1, -1]
        ]
    end

    def moves
        combined = forward_steps + side_attacks
        combined.select {|position| position.first <= 7 && position.first >= 0 }
        .select {|position| position.last <= 7 && position.first >= 0}
    end

    private

    def at_start_row?
        pos.first == 1 || pos.first == 6
        # possibly include use case of white pawn at row 6
    end

    def forward_dir
        self.color == :white ? 1 : -1
    end

    def forward_steps
        forward_moves = []
        row, col = self.pos
        start_row_step = [row + (forward_dir * 2), col]
        reg_row_step = [row + forward_dir, col]

        if (reg_row_step.first >= 0 && reg_row_step.first <= 7)
            forward_moves << start_row_step if at_start_row? && self.board[reg_row_step] == self.board.sentinel
            forward_moves << reg_row_step if self.board[reg_row_step] == self.board.sentinel
        end
        forward_moves
    end

    def side_attacks
        side_moves = []
        row, col = self.pos
        right_attack = [row + forward_dir, col + 1]
        left_attack = [row + forward_dir, col - 1]
        side_moves << right_attack if (right_attack.first >= 0 && right_attack.first <= 7) && (right_attack.last >= 0 && right_attack.last <= 7) && 
            self.board[right_attack] != self.board.sentinel && 
            self.color != self.board[right_attack].color
        side_moves << left_attack if (left_attack.first >= 0 && left_attack.first <= 7) && (left_attack.last >= 0 && left_attack.last <= 7) &&
            self.board[left_attack] != self.board.sentinel && 
            self.color != self.board[left_attack].color
        side_moves
    end

   
end