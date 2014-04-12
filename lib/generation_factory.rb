require 'generation'

class GenerationFactory
  def self.build(grid_string)
    cells = []
    x, y = 0, 0
    grid_string.chars.each do |c|
      if c == "\n"
        x = 0
        y += 1
      elsif c == 'x'
        cells << [x, y]
        x+= 1
      else
        x+= 1
      end
    end
    Generation.new(cells)
  end
end
