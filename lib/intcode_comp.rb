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
    add: -> (noun, verb, dest) {
      self[dest] = self[noun] + self[verb]
    },
    multiply: -> (noun, verb, dest) {
      self[dest] = self[noun] * self[verb]
    },
    break: -> () { raise StopIteration },
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

      args = state.slice(curr + 1, inst.parameters)
      block = inst.block
      state.instance_exec(*args, &block)

      curr += inst.parameters + 1
    end

    self
  end

  def output
    state[0]
  end
end
