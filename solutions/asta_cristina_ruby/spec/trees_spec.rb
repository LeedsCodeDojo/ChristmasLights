require 'spec_helper'
require_relative '../trees'
describe 'Trees' do
  subject(:tree) { Trees.new(3,5) }
  it 'init grid' do
    expect(tree.grid).to eq [["*", "*", "*"], ["*", "*", "*"], ["*", "*", "*"], ["*", "*", "*"], ["*", "*", "*"]]
  end

  it 'draws the grid' do
  	expect(tree.draw).to eq "***\n***\n***\n***\n***"
  end

  it 'off the lights on grid' do
    tree.off(1,1,3,2)
    expect(tree.draw).to eq("***\n*  \n*  \n*  \n***")
  end

  it 'toggle the lights on grid' do
    tree.toggle(1,1,3,2)
    expect(tree.draw).to eq("***\n*  \n*  \n*  \n***")

    tree.toggle(0,0,1,1)
    expect(tree.draw).to eq("  *\n * \n*  \n*  \n***")
  end

  it 'on the lights on grid' do
    tree.off(1,1,3,2)
    expect(tree.draw).to eq("***\n*  \n*  \n*  \n***")

    tree.on(0,0,2,1)
    expect(tree.draw).to eq("***\n** \n** \n*  \n***")
  end

  it 'off the lights when swapped' do
    tree.off(3,2,1,1)
    expect(tree.draw).to eq("***\n*  \n*  \n*  \n***")
  end

  it 'toggle the lights on grid when swapped' do
    tree.toggle(1,1,3,2)
    expect(tree.draw).to eq("***\n*  \n*  \n*  \n***")

    tree.toggle(1,1,0,0)
    expect(tree.draw).to eq("  *\n * \n*  \n*  \n***")
  end

  it 'on the lights on grid when swapped' do
    tree.off(1,1,3,2)
    expect(tree.draw).to eq("***\n*  \n*  \n*  \n***")

    tree.on(2,1,0,0)
    expect(tree.draw).to eq("***\n** \n** \n*  \n***")
  end
end