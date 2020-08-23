class Robot
  attr_accessor :x, :y, :dir, :name

  def initialize(name)
    @name = name
  end

  def place(x, y, dir)
    @x = x
    @y = y
    @dir = dir
  end

  def get_new_pos
    new_x = @x
    new_y = @y
    case @dir
    when 'NORTH'
      new_y += 1
    when 'SOUTH'
      new_y -= 1
    when 'EAST'
      new_x += 1
    when 'WEST'
      new_x -= 1
    end
    return { x:new_x, y:new_y}
  end

  def update_pos(x, y)
    @x = x
    @y = y
  end

  def turn_right
    case @dir
    when 'NORTH'
      @dir = 'EAST'
    when 'SOUTH'
      @dir = 'WEST'
    when 'EAST'
      @dir = 'SOUTH'
    when 'WEST'
      @dir = 'NORTH'
    end
  end

  def turn_left
    case @dir
    when 'NORTH'
      @dir = 'WEST'
    when 'SOUTH'
      @dir = 'EAST'
    when 'EAST'
      @dir = 'NORTH'
    when 'WEST'
      @dir = 'SOUTH'
    end
  end

  def report
    "#{@name}: #{@x},#{@y},#{@dir}"
  end
end
