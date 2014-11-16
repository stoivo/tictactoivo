require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    @game = games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post :create, game: { columns: @game.columns, end_at: @game.end_at, first_player_id: @game.first_player_id, length_to_win: @game.length_to_win, losser_id: @game.losser_id, mode: @game.mode, rows: @game.rows, secound_player_id: @game.secound_player_id, start_at: @game.start_at, started_by_id: @game.started_by_id, turn: @game.turn, winner_id: @game.winner_id }
    end

    assert_redirected_to game_path(assigns(:game))
  end

  test "should show game" do
    get :show, id: @game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game
    assert_response :success
  end

  test "should update game" do
    patch :update, id: @game, game: { columns: @game.columns, end_at: @game.end_at, first_player_id: @game.first_player_id, length_to_win: @game.length_to_win, losser_id: @game.losser_id, mode: @game.mode, rows: @game.rows, secound_player_id: @game.secound_player_id, start_at: @game.start_at, started_by_id: @game.started_by_id, turn: @game.turn, winner_id: @game.winner_id }
    assert_redirected_to game_path(assigns(:game))
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete :destroy, id: @game
    end

    assert_redirected_to games_path
  end
end
