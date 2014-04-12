class Cell
  def self.evolve(alive, neighbour_count)
    if alive
      !dies(neighbour_count)
    else
      revives(neighbour_count)
    end
  end

  def self.revives(neighbours)
    neighbours == 3
  end

  def self.dies(neighbours)
    (neighbours < 2) || (neighbours > 3)
  end
end
