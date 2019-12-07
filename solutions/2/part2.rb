require_relative '../../lib/intcode_comp'

state = File.read('puzzles/2/input')
  .split(',')
  .map(&:to_i)

(0..99).each do |noun|
  (0..99).each do |verb|
    state[1] = noun
    state[2] = verb
    output = nil

    begin
      output = IntcodeComp.new(state).run.output
    rescue NoOpCode
    rescue => e
      #puts e
    ensure
      if output == 19690720
        puts 100 * noun + verb
        exit
      end
    end
  end
end
