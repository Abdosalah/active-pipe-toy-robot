require 'minitest/autorun'
require_relative '../lib/board'

describe Board do
  before do
    @board = Board.new
  end

  it 'initializes the board with an empty array of robots and names' do
    assert_equal @board.robots, []
    assert_equal @board.names, []
  end

  describe '#place_robot' do
    describe 'when input is valid' do
      it 'should place the robot in the given position' do
        @board.place_robot('Test', 1, 3, 'NORTH')

        assert_equal @board.robots.first.x, 1
        assert_equal @board.robots.first.y, 3
      end

      it 'should place the robot in a new position if it already exists' do
        @board.place_robot('Test', 1, 3, 'NORTH')
        @board.place_robot('Test', 2, 2, 'SOUTH')

        assert_equal @board.robots.first.x, 2
        assert_equal @board.robots.first.y, 2
      end
    end

    describe 'when input is invalid' do
      it 'should not place the robot when pos is out of bounds' do
        @board.place_robot('Test', 7, 8, 'NORTH')
        assert_equal @board.robots.length, 0
      end

      it 'should not place the robot when the direction is invalid' do
        @board.place_robot('Test', 0, 0, 'LEFT')
        assert_equal @board.robots.length, 0
      end
    end

    describe 'when input is valid but position is not empty' do
      it 'should not place a robot in an occupied position' do
        @board.place_robot('Test1', 2, 2, 'NORTH')
        @board.place_robot('Test2', 2, 2, 'SOUTH')

        assert_equal @board.robots.length, 1
      end
    end
  end

  describe '#move_robot' do
    describe 'when robot exists' do
      it 'should move the robot one step forward' do
        @board.place_robot('Test', 0, 0, 'NORTH')
        @board.move_robot('Test')

        assert_equal @board.robots.first.x, 0
        assert_equal @board.robots.first.y, 1
      end

      it 'should not move if it would fall off the board' do
        @board.place_robot('Test', 0, 0, 'SOUTH')
        @board.move_robot('Test')

        assert_equal @board.robots.first.x, 0
        assert_equal @board.robots.first.y, 0
      end
    end

    describe 'when robot does not exist' do
      it 'should not do anything' do
        @board.move_robot('Test')

        assert_equal @board.robots.length, 0
      end
    end
  end

  describe '#turn_robot_right' do
    describe 'when robot exists' do
      it 'should set the robot direction 90 degrees right from its current direction' do
        @board.place_robot('Test', 0, 0, 'NORTH')
        @board.turn_robot_right('Test')

        assert_equal @board.robots.first.dir, 'EAST'
      end
    end

    describe 'when robot does not exist' do
      it 'should not do anything' do
        @board.turn_robot_right('Test')

        assert_equal @board.robots.length, 0
      end
    end
  end

  describe '#turn_robot_left' do
    describe 'when robot exists' do
      it 'should set the robot direction 90 degrees left from its current direction' do
        @board.place_robot('Test', 0, 0, 'NORTH')
        @board.turn_robot_left('Test')

        assert_equal @board.robots.first.dir, 'WEST'
      end
    end

    describe 'when robot does not exist' do
      it 'should not do anything' do
        @board.turn_robot_left('Test')

        assert_equal @board.robots.length, 0
      end
    end
  end

  describe '#report_robot' do
    describe 'when robot exists' do
      it 'should report the robots position' do
        @board.place_robot('Test', 4, 2, 'NORTH')
        position = @board.report_robot('Test')

        assert_equal position, 'Test: 4,2,NORTH'
      end
    end

    describe 'when robot does not exist' do
      it 'should not do anything' do
        position = @board.report_robot('Test')

        assert_nil position
      end
    end
  end

end