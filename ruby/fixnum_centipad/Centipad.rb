# Improves on V1 by maintaining a global object rather than passing a new array to each recursive call.
# Should reduce memory required significantly which should allow computing larger data sets.

class Centipad
  def initialize(min=1, max=9, equal=100, print=false)
    @equal = equal
    @print = print
    @current_state = (min..max).to_a
    @current_location = 1
    @solutions = 0
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
      if eval(@current_state.join()) == @equal
        puts @current_state.join() if @print
        @solutions += 1
      end
      return
    else
      # Concat
      @current_location += 1
      loop()
      @current_location -= 1

      # Add
      @current_state.insert(@current_location, '+')
      @current_location += 2
      loop()
      @current_location -= 2
      @current_state.delete_at(@current_location)

      # Subtract
      @current_state.insert(@current_location, '-')
      @current_location += 2
      loop()
      @current_location -= 2
      @current_state.delete_at(@current_location)
    end
  end
end
