require File.join(File.dirname(__FILE__), '..', 'solver.rb')

describe 'A Solved Puzzle' do

  before :each do
    @puzzle = Puzzle.new
  end

  it 'should be solved' do
    @puzzle.solved?.should be_true
  end

  it 'should have a solved_distance of zero' do
    @puzzle.solved_distance.should == 0
  end

  it 'should return a puzzle with no moves when solved' do
    @puzzle.solve.moves.should == []
  end

end

describe 'An Unsolved Puzzle' do

  before :each do
    @puzzle = Puzzle.new([[nil, 3, 8], [6, 7, 1], [5, 2, 4]])
  end

  it 'should not be solved' do
    @puzzle.solved?.should_not be_true
  end

  it 'should have a solved_distance greater than zero' do
    @puzzle.solved_distance.should > 0
  end

  it 'should return a puzzle with moves when solved' do
    @puzzle.solve.moves.count.should > 0
  end

end
