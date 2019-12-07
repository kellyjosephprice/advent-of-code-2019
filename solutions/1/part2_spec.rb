require 'minitest/autorun'
require_relative './part2.rb'

describe Fuel do
  before do
    @fuel = Fuel.new
  end

  it "returns 0 numbers less than 1" do
    (-1...1).each do |n|
      _(@fuel.get(n)).must_equal 0
    end
  end

  it "returns n for 0 < n < 9" do
    (1...9).each do |n|
      _(@fuel.get(n)).must_equal n
    end
  end

  it "works for 9" do
    _(@fuel.get(9)).must_equal 10
  end

  it "works for 10" do
    _(@fuel.get(10)).must_equal 11
  end

  it "works for 100" do
    _(@fuel.get(100)).must_equal 100 + 31 + 8
  end

  it "works for 1000" do
    _(@fuel.get(1000)).must_equal 1000 + 331 + 108 + 34 + 9 + 1
  end

  it "works for 100756" do
    _(@fuel.get(100756) - 100756).must_equal 50346
  end
end
