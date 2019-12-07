#!/usr/bin/env ruby

class Fuel
  def initialize
    @cache = {}
  end

  def get(mass)
    return 0 if mass <= 0
    return @cache[mass] if @cache[mass]

    @cache[mass] = mass + self.get((mass / 3).floor - 2)
  end
end

if __FILE__ == $0
  @filename = $1 || "puzzles/1/input"
  @fuel = Fuel.new

  puts File.readlines(@filename)
    .map(&:to_i)
    .map { |mass| @fuel.get(mass) - mass }
    .sum
end
