require_relative 'board'
require_relative 'robot'


def execute_commands
  board = Board.new
  File.foreach('test-data/example_one.txt') do |line|
    name, action = line.split(': ')

    case action
    when /PLACE/
      x, y, dir = action.split(' ').last.split(',')
      board.place_robot(name, x.to_i, y.to_i, dir)
    when /MOVE/
      board.move_robot(name)
    when /RIGHT/
      board.turn_robot_right(name)
    when /LEFT/
      board.turn_robot_left(name)
    when /REPORT/
      puts board.report_robot(name)
    else
      puts 'INVALID COMMAND'
    end
  end
end

execute_commands

