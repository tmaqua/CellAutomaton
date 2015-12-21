require "open3"

class CellAutomatonsController < ApplicationController
  before_action :set_cell_automaton, only: [:show, :show_cell, :edit, :update, :destroy]

  # GET /cell_automatons
  def index
    @cell_automatons = CellAutomaton.all
  end

  # GET /cell_automatons/1
  def show
  end

  def show_cell
    gon.array = execute_ruby_file(@cell_automaton.id)
    gon.rowNum = @cell_automaton.board_size
    gon.columnNum = @cell_automaton.board_size
    gon.step = @cell_automaton.step+1
  end

  # GET /cell_automatons/new
  def new
    @cell_automaton = CellAutomaton.new
  end

  # GET /cell_automatons/1/edit
  def edit
  end

  # POST /cell_automatons
  # POST /cell_automatons.json
  def create
    @cell_automaton = CellAutomaton.new(cell_automaton_params)

    respond_to do |format|
      if @cell_automaton.save
        format.html { redirect_to @cell_automaton, notice: 'Cell automaton was successfully created.' }
        format.json { render :show, status: :created, location: @cell_automaton }
      else
        format.html { render :new }
        format.json { render json: @cell_automaton.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cell_automatons/1
  # PATCH/PUT /cell_automatons/1.json
  def update
    respond_to do |format|
      if @cell_automaton.update(cell_automaton_params)
        format.html { redirect_to @cell_automaton, notice: 'Cell automaton was successfully updated.' }
        format.json { render :show, status: :ok, location: @cell_automaton }
      else
        format.html { render :edit }
        format.json { render json: @cell_automaton.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cell_automatons/1
  # DELETE /cell_automatons/1.json
  def destroy
    @cell_automaton.destroy
    respond_to do |format|
      format.html { redirect_to cell_automatons_url, notice: 'Cell automaton was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cell_automaton
      @cell_automaton = CellAutomaton.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cell_automaton_params
      params.require(:cell_automaton).permit(:name, :board_size, :step, :state_num, :init_type, :neighbor_rule)
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

    def gen_str_function()
      str = 
      "
      
      def print_array(array)
        array.each do |two_dimension|
          two_dimension.each do |one_dimension|
            print one_dimension
          end
          print 'ENTER'
        end
      end
      
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
        #{@cell_automaton.neighbor_rule}
      end

      size = #{@cell_automaton.board_size}
      step = #{@cell_automaton.step}
      result = calc_automaton(board_init(size), step, size)
      print_array(result)
      "

      str
    end
end
