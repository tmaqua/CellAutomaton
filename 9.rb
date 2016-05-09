
      
      def print_array(array)
        array.each do |two_dimension|
          two_dimension.each do |one_dimension|
            print one_dimension
          end
          print 'ENTER'
        end
      end
      
      def board_init(size)
        #init_array = Array.new(size){ Array.new(size){ rand(0..1) } }
        max_value = 3 - 1
        init_array = Array.new(size){ Array.new(size){ rand(0..max_value) } }
      end

      def calc_automaton(init_array, step, size)
        result = [init_array]
        step.times do |n|
          old_array = result[n]
          new_array = Array.new(size){Array.new(size)}
          old_array.each_with_index do |old_array_row, y|
            old_array_row.each_with_index do |now_state, x|
              new_array[y][x] = judge_next_state(count_true_state(old_array, y, x), now_state)
            end
          end
          result.push(new_array)
        end
        result
      end

      def count_true_state(array, y, x)
        counter = 0

        counter = (y-1 >= 0 && x-1 >= 0 && array[y-1][x-1] == 1) ? counter+1 : counter+0
        counter = (y-1 >= 0 && array[y-1][x+0] == 1) ? counter+1 : counter+0
        counter = (y-1 >= 0 && array[y-1][x+1] == 1) ? counter+1 : counter+0

        counter = (x-1 >= 0 && array[y+0][x-1] == 1) ? counter+1 : counter+0
        # counter = (array[y+0][x+0] && array[y+0][x+0] == 1) ? counter+1 : counter+0
        counter = (array[y+0][x+1] == 1) ? counter+1 : counter+0

        counter = (array[y+1] && x-1 >= 0 && array[y+1][x-1] == 1) ? counter+1 : counter+0
        counter = (array[y+1] && array[y+1][x+0] == 1) ? counter+1 : counter+0
        counter = (array[y+1] && array[y+1][x+1] == 1) ? counter+1 : counter+0
        
        counter
      end

      def judge_next_state(state_count, now_state)
        if (now_state == 0 && (state_count >= 3 && state_count <= 3))
    1
   elsif (now_state == 1 && (state_count >= 2 && state_count <= 3))
    2
   else
    0
  end
      end

      size = 50
      step = 20
      result = calc_automaton(board_init(size), step, size)
      print_array(result)
      