module Stepable
    attr_reader :symbol

    def moves
        possible_moves = []
        pos = self.pos
        row, col = pos

        self.move_diffs.each do |(row_dir, col_dir)|
            row_idx = row + row_dir
            col_idx = col + col_dir
            
            if (row_idx >= 0 && row_idx <= 7) && (col_idx >= 0 && col_idx <= 7)
                unless self.board[[row_idx, col_idx]] != self.board.sentinel && self.color == self.board[[row_idx, col_idx]].color
                    possible_moves << [row_idx, col_idx]
                end
            end
        end

        possible_moves
    end

    private
    
    def move_diffs
        raise "move_diffs not implemented"
    end
end

#if piece.color == self.color, it's not a valid move. but make sure to break out of loop