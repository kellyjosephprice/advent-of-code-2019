#!/usr/bin/env ruby

state = File.read('puzzles/2/input')
  .split(',')
  .map(&:to_i)

ops = {
  1 => :+,
  2 => :*,
}

state[1] = 12
state[2] = 2

puts state.join(",")
state.each_slice(4) do |op, one, two, dest|
  break if op == 99

  state[dest] = state[one].send(ops[op], state[two])
end

puts state[0]
