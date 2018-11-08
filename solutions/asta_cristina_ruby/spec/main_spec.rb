require 'spec_helper'
require_relative '../main'
describe 'Main' do
  subject(:main) { Main.new }
  it 'will read the file' do
    main.read('./spec/test_file1.xl')
    expect(main.listing).to eq ['OFF (0,0)(1,1)']
  end

  it 'will read a bigger file' do
    main.read('./spec/test_file2.xl')
    expect(main.listing).to eq ["TREE (10,10)", 'OFF (0,0)(1,1)','TOGGLE (3,2)(9,8)','ON (2,2)(9,2)']
  end

  it 'will draw the tree' do
    main.read('./spec/test_file2.xl')
    expect(main.draw_tree).to eq('  ********
  ********
**********
***      *
***      *
***      *
***      *
***      *
***      *
***      *')
  end
end