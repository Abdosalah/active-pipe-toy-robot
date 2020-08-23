require_relative 'robot'

class Board
  attr_accessor :robots, :names

  def initialize
    @robots = []
    @names = []
  end

  def place_robot(name, x, y, dir)
    if is_pos_valid(x,y) && is_dir_valid(dir) && is_pos_empty(x, y)
      robot = add_or_find_robot(name)
      robot.place(x, y, dir)
    end
  end

  def move_robot(name)
    robot = find_robot(name)
    if robot
      pos = robot.get_new_pos
      if (is_pos_valid(pos[:x], pos[:y]) && is_pos_empty(pos[:x], pos[:y]))
        robot.update_pos(pos[:x], pos[:y])
      end
    end
  end

  def turn_robot_right(name)
    find_robot(name) && find_robot(name).turn_right
  end

  def turn_robot_left(name)
    find_robot(name) && find_robot(name).turn_left
  end

  def report_robot(name)
    find_robot(name) && find_robot(name).report
  end

  private

  def add_or_find_robot(name)
    unless player_exists?(name)
      new_robot = Robot.new(name)
      @robots << new_robot
      @names << name
      new_robot
    else
      find_robot(name)
    end
  end

  def find_robot(name)
    @robots.select {|robot| robot.name == name}.first
  end

  def player_exists?(name)
    @names.include?(name)
  end

  def is_pos_valid(x, y)
    x.between?(0,5) && y.between?(0,5)
  end

  def is_dir_valid(dir)
    valid_dir = ['NORTH', 'SOUTH', 'EAST', 'WEST'].freeze
    valid_dir.include?(dir.chomp.upcase)
  end

  def is_pos_empty(x, y)
    is_empty = true
    @robots.each do |robot|
      is_empty = false if (robot.x == x && robot.y == y)
    end
    is_empty
  end

end