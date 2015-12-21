class LifegamesController < ApplicationController
  before_action :set_lifegame, only: [:show, :edit, :update, :destroy]

  # GET /lifegames
  # GET /lifegames.json
  def index
    @lifegames = Lifegame.all
  end

  # GET /lifegames/1
  # GET /lifegames/1.json
  def show
    size = @lifegame.board_size
    step = @lifegame.step

    gon.array = calc_automaton(board_init(size), step, size)
    gon.rowNum = size
    gon.columnNum = size
    gon.step = step+1
  end

  # GET /lifegames/new
  def new
    @lifegame = Lifegame.new
  end

  # GET /lifegames/1/edit
  def edit
  end

  # POST /lifegames
  # POST /lifegames.json
  def create
    @lifegame = Lifegame.new(lifegame_params)

    respond_to do |format|
      if @lifegame.save
        format.html { redirect_to @lifegame, notice: 'Lifegame was successfully created.' }
        format.json { render :show, status: :created, location: @lifegame }
      else
        format.html { render :new }
        format.json { render json: @lifegame.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lifegames/1
  # PATCH/PUT /lifegames/1.json
  def update
    respond_to do |format|
      if @lifegame.update(lifegame_params)
        format.html { redirect_to @lifegame, notice: 'Lifegame was successfully updated.' }
        format.json { render :show, status: :ok, location: @lifegame }
      else
        format.html { render :edit }
        format.json { render json: @lifegame.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lifegames/1
  # DELETE /lifegames/1.json
  def destroy
    @lifegame.destroy
    respond_to do |format|
      format.html { redirect_to lifegames_url, notice: 'Lifegame was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lifegame
      @lifegame = Lifegame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lifegame_params
      params.require(:lifegame).permit(:board_size, :step, :state_num, :state_count_range, :live_count_min, :live_count_max, :retention_count_min, :retention_count_max)
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
      if now_state == 0 && (state_count >= @lifegame.live_count_min && state_count <= @lifegame.live_count_max) # 誕生
        1
      elsif now_state == 1 && (state_count >= @lifegame.retention_count_min && state_count <= @lifegame.retention_count_max) # 維持
        1
      else # 死
        0
      end
    end
end
