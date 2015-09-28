class PlayController < ApplicationController
  def index
    size = 50
    step = 100

    gon.array = calc_automaton(board_init(size), step, size)
    gon.rowNum = size
    gon.columnNum = size
    gon.step = step+1
  end

  private
  def board_init(size)
    init_array = Array.new(size){ Array.new(size){ rand(0..1) } }
  end

  def calc_automaton(init_array, step, size)
    result = [init_array]
    step.times do |n|

      old_array = result[n]
      new_array = Array.new(size){Array.new(size)}
      old_array.each_with_index do |old_array_row, y|
        old_array_row.each_with_index do |now_state, x|
          new_array[y][x] = judge_live(count_true_state(old_array, y, x), now_state)
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

  def judge_live(state_count, now_state)
    if now_state == 0 && state_count == 3 # 誕生
      1
    elsif now_state == 1 && (state_count == 2 || state_count == 3) # 維持
      1
    else # 死
      0
    end
  end

end
