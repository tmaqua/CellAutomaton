require "open3"

class CellAutomatonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cell_automaton, only: [:show, :edit, :update, :destroy]

  # GET /cell_automatons
  def index
    if user_signed_in?
      @cell_automatons = current_user.cell_automatons
    else
      @cell_automatons = CellAutomaton.all
    end
  end

  # GET /cell_automatons/1
  def show
    file_path = Rails.root.join("public", "cell_automatons", "#{current_user.id}")
    file_name = file_path.to_s + "/" + @cell_automaton.id.to_s

    gon.array = execute_ruby_file(file_name)
    gon.rowNum = @cell_automaton.height
    gon.columnNum = @cell_automaton.width
    gon.step = @cell_automaton.step+1
    gon.stateNum = @cell_automaton.state_num
    gon.colors = @cell_automaton.cells.pluck(:color)
  end

  # GET /cell_automatons/new
  def new
    @cell_automaton = CellAutomaton.new
    2.times{ @cell_automaton.cells.build }
  end

  # GET /cell_automatons/1/edit
  def edit
  end

  # POST /cell_automatons
  # POST /cell_automatons.json
  def create
    @cell_automaton = CellAutomaton.new(cell_automaton_params)
    @cell_automaton.user_id = user_signed_in? ? current_user.id : 0

    if @cell_automaton.save
      redirect_to @cell_automaton, notice: 'Cell automaton was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /cell_automatons/1
  # PATCH/PUT /cell_automatons/1.json
  def update
    if @cell_automaton.update(cell_automaton_params)
      redirect_to @cell_automaton, notice: 'Cell automaton was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /cell_automatons/1
  # DELETE /cell_automatons/1.json
  def destroy
    @cell_automaton.destroy
    file_path = Rails.root.join("public", "cell_automatons", "#{current_user.id}")
    file_name = file_path.to_s + "/" + @cell_automaton.id.to_s
    File.delete("#{file_name}.rb")
    
    redirect_to cell_automatons_url, notice: 'Cell automaton was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cell_automaton
      @cell_automaton = CellAutomaton.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cell_automaton_params
      params.require(:cell_automaton).permit(
        :name, :board_size, :step, :state_num, :init_type, :neighbor_rule, :init_rule, :width, :height,
        cells_attributes: [
          :id, :cell_automaton_id, :color, :_destroy
        ]
      )
    end

    def execute_ruby_file(file_name)
      File.write("#{file_name}.rb", gen_str_function)
      out, err, status = Open3.capture3("ruby #{file_name}.rb")
      stdstr_to_array(out)
    end

    def stdstr_to_array(str)
      result = Array.new()
      hoge = Array.new()
      str.split("ENTER").each do |item|
        item.gsub!(/\[|\s/, "")
        hoge.push(item.split("]"))
      end

      hoge.each do |items|
        temp = Array.new()
        hoge = Array.new()
        items.each do |item|
          temp.push(item.split(",").map(&:to_i))
        end
        result.push(temp)
      end
      result
    end

    def generate_function_print_array
      "
      def print_array(array)
        array.each do |two_dimension|
          two_dimension.each do |one_dimension|
            print one_dimension
          end
          print 'ENTER'
        end
      end
      "
    end

    def generate_function_board_init
      "
      def board_init(width, height)
        init_array = Array.new(width){ Array.new(height){-1} }
        #{@cell_automaton.init_rule}
        init_array
      end
      "
    end

    def generate_function_calc_automaton
      "
      def calc_automaton(init_array, step, width, height)
        result = [init_array]
        step.times do |n|
          old_array = result[n]
          new_array = Array.new(width){Array.new(height)}
          old_array.each_with_index do |old_array_row, y|
            old_array_row.each_with_index do |now_state, x|
              new_array[y][x] = judge_next_state(count_true_state(old_array, y, x), now_state, old_array, x, y, width, height)
            end
          end
          result.push(new_array)
        end
        result
      end
      "
    end

    def generate_function_judge_next_state
      "
      def judge_next_state(state_count, now_state, now_array, x, y, width, height)
        #{@cell_automaton.neighbor_rule}
      end
      "
    end

    def generate_function_count_state
      "
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
      "
    end

    def gen_str_function()
      str = 
      "
      #{generate_function_print_array()}
      #{generate_function_board_init()}
      #{generate_function_calc_automaton()}
      #{generate_function_judge_next_state()}
      #{generate_function_count_state()}
      
      width = #{@cell_automaton.width}
      height = #{@cell_automaton.height}
      step = #{@cell_automaton.step}
      result = calc_automaton(board_init(width, height), step, width, height)
      print_array(result)
      "

      str
    end
end
