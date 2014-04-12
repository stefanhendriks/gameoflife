require 'cell'

class Generation

  attr_reader :alive_cells, :dead_cells

  def initialize(alive_cells)
    @alive_cells = alive_cells
    @dead_cells = []
    alive_cells.each do |x, y|
      @dead_cells << [x - 1, y - 1]
      @dead_cells << [x, y - 1]
      @dead_cells << [x + 1, y - 1]

      @dead_cells << [x - 1, y]
      @dead_cells << [x + 1, y]

      @dead_cells << [x - 1, y + 1]
      @dead_cells << [x, y + 1]
      @dead_cells << [x + 1, y + 1]
    end
    @dead_cells = @dead_cells - @alive_cells # remove alive cells which we accidentally marked as dead
  end

  def next
    next_gen = []
    @alive_cells.map do |cell|
      count = Generation.neighbour_count(cell, @alive_cells)
      next_gen << cell if Cell.evolve(true, count)
    end

    @dead_cells.map do |dead_cell|
      count = Generation.neighbour_count(dead_cell, @alive_cells)
      next_gen << dead_cell if Cell.evolve(false, count)
    end
    next_gen.uniq
  end

  def self.neighbour_count(pos, cells)
    pos_x, pos_y = *pos
    neighbours = 0
    cells.each do |x, y|
      if neighbours?(pos_x, pos_y, x, y)
        #p "#{pos} is neighbours with #{x},#{y}"
        neighbours += 1
      end
    end
    neighbours
  end

  def self.neighbours?(pos_x, pos_y, x, y)
    dist_x = distance(pos_x, x).abs
    dist_y = distance(pos_y, y).abs
    return true if (dist_x == 1 && dist_y == 0)
    return true if (dist_x == 0 && dist_y == 1)
    return true if (dist_x == 1 && dist_y == 1)
    false
  end

  def self.distance(pos_x, x)
    (pos_x - x)
  end
end
