class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    # @plots = @game.plots.order("vertical asc").order("horizontal asc")

    # @plots2D = []
    # @game.rows.times do |j|
    #   @plots2D[j] = []
    #   row = @game.plots.where(horizontal: j).order("vertical asc")
    #   row.each_index do |i|
    #     @plots2D[j] << row[i]
    #   end
    # end
    # # lag en 2D array
    # # [
    # #   [row1 colom1,row1 colom2,row1 colom3],
    # #   [row2 colom1,row2 colom2,row2 colom3],
    # #   [row3 colom1,row3 colom2,row3 colom3]
    # # ]
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:started_by_id, :winner_id, :losser_id, :first_player_id, :secound_player_id, :turn, :rows, :columns, :length_to_win, :mode, :start_at, :end_at)
    end
end
