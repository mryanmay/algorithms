# Improves on v3 by catching unnecessary concat in the case of very negative current state.
# Still always building the Add and Subtract

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
      concat = true

      # If no + yet or the most recent is addition, current term should be no more than 100 larger than rest of remaining numbers (maybe ensure length before eval'ing?)
      if @current_location > 1 && @current_location + 1 < @current_state.size
        current_value = eval(@current_state[0,@current_location].join())
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
      @current_state.insert(@current_location, '+')
      @current_location += 2
      @last_add = true
      loop()
      @current_location -= 2
      @current_state.delete_at(@current_location)

      # Subtract Operation
      @current_state.insert(@current_location, '-')
      @current_location += 2
      @last_add = false
      loop()
      @current_location -= 2
      @current_state.delete_at(@current_location)
    end
  end
end
