require File.join(File.dirname(__FILE__), '..', 'tile_puzzle', 'puzzle')

class Puzzle

  ##
  ## Compute distance each tile is away from its solved position
  ## and aggregate the score for the entire puzzle
  ## 
  ##   Pythagorean Theorem => X**2 + Y**2 = Z**2
  ##
  ## Skip the square root and stick with integer math
  ##
  def solved_distance
    score = 0
    @tiles.size.times do |x|
      @tiles.size.times do |y|
        n = (@tiles[y][x] or @tiles.size**2)
        score += (x - ((n-1) % @tiles.size))**2 +  ## distance on x axis
                 (y - ((n-1) / @tiles.size))**2    ## distance on y axis
      end     
    end
    score
  end

  ##
  ## Make a copy of the puzzle for each possible move
  ## Stuff each clone into the queue and reorder by:
  ##   How solved it is + How many moves to get there
  ## 
  ## Not memory friendly :-)
  ##
  def solve
    queue = [self]
    seen = {}
    loop do
      return nil unless p = queue.shift
      return p if p.solved?
      unless seen[p.to_s]
        p.available_moves.each do |move|
          p2 = p.clone.move(*move)
          queue << p2
          queue = queue.sort_by {|a| a.moves.size + a.solved_distance} 
          seen[p.to_s] = true
        end
      end
    end
  end

end
