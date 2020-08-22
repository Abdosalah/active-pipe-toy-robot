require 'minitest/autorun'
require_relative '../lib/robot'

describe Robot do
  before do
    @robot = Robot.new('Test')
  end

  it 'initializes a robot with the given name' do
    refute_nil @robot.name
    assert_equal @robot.name, 'Test'
  end

  it 'places the robot in the given position and direction' do
    @robot.place(1, 2, 'NORTH')

    assert_equal @robot.x, 1
    assert_equal @robot.y, 2
    assert_equal @robot.dir, 'NORTH'
  end

  it 'returns the new position based on current direction' do
    @robot.place(1, 2, 'SOUTH')

    assert_equal @robot.get_new_pos[:x], 1
    assert_equal @robot.get_new_pos[:y], 1
  end

  it 'updates the robot position based on given coordinates' do
    @robot.update_pos(2, 3)

    assert_equal @robot.x, 2
    assert_equal @robot.y, 3
  end

  it 'sets the robot direction 90 degrees right from its current direction' do
    @robot.place(1, 2, 'EAST')
    @robot.turn_right

    assert_equal @robot.dir, 'SOUTH'
  end

  it 'sets the robot direction 90 degrees left from its current direction' do
    @robot.place(4, 5, 'WEST')
    @robot.turn_left

    assert_equal @robot.dir, 'SOUTH'
  end

  it 'reports the robot name, current position and direction' do
    @robot.place(4, 3, 'EAST')

    assert_equal @robot.report, 'Test: 4,3,EAST'
  end
end