#!/usr/bin/env ruby
require_relative 'board'

def execute_commands
  board = Board.new
  File.foreach("test-data/#{ARGV.first || 'example_one.txt'}") do |line|
    # I extract the name which is used as an identifier for the robot
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
      puts 'Invalid command'
    end
  end
end

execute_commands
