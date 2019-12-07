#!/usr/bin/env ruby

require_relative '../../lib/intcode_comp'

state = File.read('puzzles/2/input')
  .split(',')
  .map(&:to_i)

state[1] = 12
state[2] = 2

puts IntcodeComp.new(state).run.output
