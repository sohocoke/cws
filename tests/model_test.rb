require "test/unit"
require "model.rb"

class ModelTest < Test::Unit::TestCase
  
  def test_create_stub_state_1
    master_plot = Plot.new

    # add a few plots to master
    child_plot_1 = Plot.new
    child_plot_2 = Plot.new("2nd-child-plot")
    master_plot.add child_plot_1
    master_plot.add child_plot_2
    puts master_plot
    
    # add a stroke to a plot
    child_plot_2.add Stroke.new( [ [0,0], [10,10], [20, 0] ] )
    puts child_plot_2
  end
  
end