require 'singleton'
require_relative 'board.rb'
require "colorize"
require "byebug"

module Slideable
    HORIZONTAL_DIRS ||= [[-1, 0], [1, 0],[0, 1], [0, -1]]
    DIAGONAL_DIRS ||= [[1, 1], [1, -1], [-1, -1], [-1, 1]]
    
    public
    def horizontal_dirs
        HORIZONTAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def moves
        pos = self.position
        result = []

        directions = self.move_dirs
        directions.each_with_index do |direction, i|
            loop = true
            while loop
                result[i][0] += pos[0] + direction[0]
                result[i][1] += pos[1] + direction[1]
                if move[0] > 7 || move[0] < 0 || move[1] > 7 || move[1] < 0 
                    loop = false
                end
            end
        end

        result
    end

    private

    def move_dirs
        symbol = self.piece.symbol
        case symbol

        when :bishop
            diagonal_dirs
        when :rook
            horizontal_dirs
        when :queen
            diagonal_dirs.concat horizontal_dirs
        end
        
    end

    def grow_unblocked_moves_in_dir(dx, dy)

    end

end

module Stepable
    def moves
        pos = self.position
        result = Array.new(2) { Array.new(2,0) }

        diffs = self.move_diffs

        # [0,1] 
        # [1,1]
        diffs.each_with_index do |diff,i|
            debugger
            result[i][0] += pos[0] + diff[0]
            result[i][1] += pos[1] + diff[0]
        end

        result
    end

    private
    def move_diffs
        raise "Move diffs not passed into piece"
    end
end

class Piece 
    attr_reader :position, :board, :color

    def initialize(position, board, color)
        @position = position
        @board = board
        @color = color
    end

    def to_s
        self.symbol[0].to_s.colorize(:color => self.color)
    end

    def empty?
        self == NullPiece
    end

    def valid_moves
        possible_moves = self.moves
        valid = []
        possible_moves.each do |pos|
            if self.board.grid.[](pos) == NullPiece || self.board.grid.[](pos).color != self.color
                valid << pos
            end
        end
        valid
    end

    def pos=(val)
        current_pos = self.position
        board.[]= current_pos, NullPiece.instance
        board.[]= val, self
        position = val
    end

    def symbol
        symbol
    end

    private
    def move_into_check?(end_pos)

    end

end

class Rook < Piece
    include Slideable

    def symbol
        :rook
    end
end

class Bishop < Piece
    include Slideable

    def symbol
        :bishop
    end
end

class Queen < Piece
    include Slideable

    def symbol
        :queen
    end
end

class Knight < Piece
    include Stepable

    def symbol
        :knight
    end

    def move_diffs
        return [[2,1], [1, 2], [-2, 1], [-1, 2], [-2, -1], [-1, -2], [2, -1], [1, -2]]
    end
end

class King < Piece
    include Stepable

    def symbol
        :king
    end

    def move_diffs
        return [[1,0], [-1, 0], [0, -1], [0, 1]]
    end
end

class Pawn < Piece
    def symbol
        :pawn
    end

    def move_dirs
        moves = [[0, 1], [0, -1]]
    end

    private

    def at_start_row?
        if position[1] == 1 && self.color == "black"
            return true
        elsif position[1] == 6 && self.color == "white"
            return true
        else
            return false
        end
    end

    def forward_dir
        if self.color == "black"
            returns 1
        else
            return -1
        end
    end

    def forward_steps
        if self.at_start_row?
            moves << [[0, 2], [0, -2]]
        end
    end

    def side_attacks
        if self.color == "black"
            adjacent_pos = board.grid.position[self.position[0] + 1, self.position[0] + 1]
            if adjacent_pos.color == "white"
                moves << adjacent_pos
            end
        else
            adjacent_pos = board.grid.position[self.position[0] + 1, self.position[0] + 1]
            if adjacent_pos.color == "black"
                moves << adjacent_pos
            end
        end
    end
end

class NullPiece < Piece
    include Singleton

    attr_reader :color, :symbol

    def initialize
        @color = ' '
        @symbol = ' '
    end

end