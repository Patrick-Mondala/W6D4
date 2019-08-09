module Slideable
    

    def moves
        possible_moves = []

        self.move_dirs.each do |(row_dir, col_dir)|
            possible_moves += grow_unblocked_moves_in_dir(row_dir, col_dir)
        end
        possible_moves
    end

    private

    DIAGS = [
        [-1, 1],
        [-1, -1],
        [1, 1],
        [1, -1]
    ]

    HOZT = [
        [0, -1],
        [0, 1],
        [1, 0],
        [-1, 0]
    ]

    def horizontal_dirs
        HOZT
    end

    def diagonal_dirs
        DIAGS
    end

    def move_dirs
        raise "move_dirs not implemented"
    end

    def grow_unblocked_moves_in_dir(dx, dy)
        unblocked_moves = []
        begin
            position = [self.pos.first + dx, self.pos.last + dy]
        rescue NoMethodError
            return unblocked_moves
        end

        return unblocked_moves if (position.first < 0 || position.first > 7) || (position.last < 0 || position.last > 7)
        until (position.first < 0 || position.first > 7) || (position.last < 0 || position.last > 7) || self.board[position] != self.board.sentinel
                unblocked_moves << position
                position = [position.first + dx, position.last + dy]
        end

        position = [position.first - dx, position.last - dy] if (position.first < 0 || position.first > 7) || (position.last < 0 || position.last > 7)
        if self.board[position] != self.board.sentinel
            unblocked_moves << position unless self.color == self.board[position].color
        end

        unblocked_moves
    end
end