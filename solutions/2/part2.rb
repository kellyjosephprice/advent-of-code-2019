#!/usr/bin/env ruby

require 'byebug'

class NoOpCode < RuntimeError
  def initialize(op)
    @op = op
  end

  def message
    "No op code for #{@op}"
  end
end

class InstructionSet
  Instruction = Struct.new(:op, :block, :parameters)

  @@blocks = {
    add: -> (state, noun, verb, dest) {
      state[dest] = state[noun] + state[verb]
    },
    multiply: -> (state, noun, verb, dest) {
      state[dest] = state[noun] * state[verb]
    },
    break: -> (_) { raise StopIteration },
  }

  def initialize(*instructions)
    @instructions = instructions.map do |op, block, parameter|
      raise RuntimeError unless @@blocks.has_key?(block)

      [op, Instruction.new(op, @@blocks[block], parameter)]
    end.to_h
  end

  def [](op)
    raise NoOpCode.new(op) unless @instructions.has_key?(op)

    @instructions[op]
  end
end

class IntcodeComp
  attr_reader :state

  @@instructions = InstructionSet.new(
    [1, :add, 3],
    [2, :multiply, 3],
    [99, :break, 0],
  )

  def initialize(state)
    @state = state.dup
  end

  def run
    curr = 0

    loop do
      inst = @@instructions[state[curr]]

      inst.block.call(state, *state.slice(curr, inst.parameters))

      curr += inst.parameters + 1
    end

    self
  end

  def output
    state[0]
  end
end

state = File.read('puzzles/2/input')
  .split(',')
  .map(&:to_i)


(0..99).each do |noun|
  (0..99).each do |verb|
    state[1] = noun
    state[2] = verb

    if IntcodeComp.new(state).run.output == 19690720
      puts 100 * noun + verb
      exit
    end
  end
end
