require 'singleton'
require_relative 'piece.rb'

class Board
    attr_accessor :grid

    def initialize
        @grid = Array.new(8) {Array.new(8)}
        populate(grid)
    end

    # pos = [0,5]
    # row = 0
    # col = 5
    # grid[row][col]

    def [](pos)
        grid[pos[0]][pos[1]]
    end
    
    def []= (pos,val)
        row = pos[0]
        col = pos[1]
        grid[pos[0]][pos[1]] = val
    end

    def populate(grid)
        grid.each_with_index do |row, idx|
            if idx == 0 || idx == 7
                row.each_with_index do |pos, num|
                    case num
                    when 0
                        if idx == 0
                            rook = Rook.new([idx, num], self, :black)
                        elsif idx == 7
                            rook = Rook.new([idx, num], self, :white)
                        end
                        grid[idx][num] = rook
                    when 1
                        if idx == 0
                            knight = Knight.new([idx, num], self, :black)
                        elsif idx == 7
                            knight = Knight.new([idx, num], self, :white)
                        end
                        grid[idx][num] = knight 
                    when 2
                        if idx == 0
                            bishop = Bishop.new([idx, num], self, :black)
                        elsif idx == 7
                            bishop = Bishop.new([idx, num], self, :white)
                        end
                        grid[idx][num] = bishop
                    when 3 
                        if idx == 0
                            queen = Queen.new([idx, num], self, :black)
                        elsif idx == 7
                            queen = Queen.new([idx, num], self, :white)
                        end
                        grid[idx][num] = queen
                    when 4 
                        if idx == 0
                            king = King.new([idx, num], self, :black)
                        elsif idx == 7
                            king = King.new([idx, num], self, :white)
                        end
                        grid[idx][num] = king
                    when 5
                        if idx == 0
                            bishop = Bishop.new([idx, num], self, :black)
                        elsif idx == 7
                            bishop = Bishop.new([idx, num], self, :white)
                        end
                        grid[idx][num] = bishop
                    when 6
                        if idx == 0
                            knight = Knight.new([idx, num], self, :black)
                        elsif idx == 7
                            knight = Knight.new([idx, num], self, :white)
                        end
                        grid[idx][num] = knight
                    when 7
                        if idx == 0
                            rook = Rook.new([idx, num], self, :black)
                        elsif idx == 7
                            rook = Rook.new([idx, num], self, :white)
                        end
                        grid[idx][num] = rook
                    end
                end
            elsif idx ==  1 || idx == 6
                row.each_with_index do |pos, num|
                    if idx == 1
                        pawn = Pawn.new([idx, num], self, :black)
                    elsif idx == 6
                        pawn = Pawn.new([idx, num], self, :white)
                    end
                    grid[idx][num] = pawn
                end
            else
                row.each_with_index do |pos,num|
                    nullpiece = NullPiece.instance
                    grid[idx][num] = nullpiece
                end
            end
        end
    end

    # start_pos, end_pos : [x,y]
    # end_pos = [9,2]
    # if end_pos[0] > 7 || end_pos[0] < 0 || end_pos[1] > 7 || end_pos[1] < 0 
    # move_piece([0,2],[1,3])

    def move_piece(start_pos,end_pos)
        begin  
            raise "No piece here to move" if grid[start_pos[0]][start_pos[1]].nil?
            raise "Can't move to this spot" if end_pos[0] > 7 || end_pos[0] < 0 || end_pos[1] > 7 || end_pos[1] < 0 
            self[start_pos], self[end_pos] = self[end_pos],self[start_pos]
        end
    end

   
end

# class Piece
#     attr_reader :name
#     def initialize(name)
#         @name = name
#     end
# end

# class NullPiece
#     include Singleton

#     attr_reader :name

#     def initialize
#         @name = ' '
#     end
# end
