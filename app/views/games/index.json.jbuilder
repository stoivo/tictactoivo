json.array!(@games) do |game|
  json.extract! game, :id, :started_by_id, :winner_id, :losser_id, :first_player_id, :secound_player_id, :turn, :rows, :columns, :length_to_win, :mode, :start_at, :end_at
  json.url game_url(game, format: :json)
end
