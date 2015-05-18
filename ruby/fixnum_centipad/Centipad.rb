# Features:
#   + Global object memory optimization (v2)
#   + Concat limiting (v3, v4)
#   + Add limiting (v5)
#   + Subtract limiting (v5)
#
# Potential Improvements:
#   - current_value not always available or may be evaluated too often
#   - ditch eval() for faster expression evaluator (build one?)
#   - change arguments to a params hash

class Centipad
  def initialize(min=1, max=9, equal=100, print=false)
    @equal = equal
    @print = print
    @current_state = (min..max).to_a
    @current_location = 1
    @solutions = 0
    @last_add = true
  end

  def solve()
    beginning_time = Time.now
    loop()
    end_time = Time.now
    puts @solutions.to_s
    puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"
  end

  def loop()
    if @current_location >= @current_state.size
      # Evaluate and print
      solution = @current_state.join()
      if eval(solution) == @equal
        puts solution if @print
        @solutions += 1
      end
      return
    else
      # Concat limiting logic
      concat = true
      current_value = nil

      # TODO: Revisit this if statement. Not sure about @current_state.size/2 being the optimal case.
      if @current_location > @current_state.size/2 && @current_location + 1 < @current_state.size
        current_value = eval(@current_state[0,@current_location].join())

        # If no + yet or the most recent is addition, current term should be no more than 100 larger than rest of remaining numbers
        if @last_add == true && current_value > @current_state[@current_location+1, @current_state.size-1].join().to_i + @equal
          concat = false
        end
        if @last_add == false &&  current_value < -(@current_state[@current_location+1, @current_state.size-1].join().to_i + @equal)
          concat = false
        end
      end

      # Concat Operation
      if concat
        @current_location += 1
        loop()
        @current_location -= 1
      end

      # Add Operation
      if current_value.nil? || current_value >= -(@current_state[@current_location, @current_state.size-1].join().to_i + @equal)
        @current_state.insert(@current_location, '+')
        @current_location += 2
        @last_add = true
        loop()
        @current_location -= 2
        @current_state.delete_at(@current_location)
      end

      # Subtract Operation
      if current_value.nil? || current_value <= @current_state[@current_location, @current_state.size-1].join().to_i + @equal
        @current_state.insert(@current_location, '-')
        @current_location += 2
        @last_add = false
        loop()
        @current_location -= 2
        @current_state.delete_at(@current_location)
      end
    end
  end
end
