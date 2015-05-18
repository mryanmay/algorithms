# Improves on v2 by limiting the concat recursion if very positive (unable to be within @equal) in current state

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
      # Concat
      # If no + yet or the most recent is addition, current term should be no more than 100 larger than rest of remaining numbers (maybe ensure length before eval'ing?)
      unless @last_add == true && @current_location > 1 && @current_location + 1 < @current_state.size && eval(@current_state[0,@current_location].join()) > @current_state[@current_location+1, @current_state.size-1].join().to_i + @equal
        @current_location += 1
        loop()
        @current_location -= 1
      end

      # Add
      @current_state.insert(@current_location, '+')
      @current_location += 2
      @last_add = true
      loop()
      @current_location -= 2
      @current_state.delete_at(@current_location)

      # Subtract
      @current_state.insert(@current_location, '-')
      @current_location += 2
      @last_add = false
      loop()
      @current_location -= 2
      @current_state.delete_at(@current_location)
    end
  end
end
