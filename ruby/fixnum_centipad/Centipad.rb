# simple (read: dumb) recursion algorithm. Lots of room for optimization.

class Centipad
  def solve()
    @solutions = 0
    beginning_time = Time.now
    start = (1..9).to_a
    loop(start)
    end_time = Time.now
    puts @solutions.to_s
    puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"
  end
  def loop(current_array, current_location=1)
    if current_location >= current_array.size
      # Evaluate and print
      if eval(current_array.join()) == 100
        # puts current_array.join()
        @solutions += 1
      end
      return
    else
      # Concat
      loop(current_array, current_location+1)
      # Add
      loop(current_array.dup.insert(current_location, '+'), current_location+2)
      # Subtract
      loop(current_array.dup.insert(current_location, '-'), current_location+2)
    end
  end
end
