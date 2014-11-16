class Game < ActiveRecord::Base
  # belongs_to :start_by, :class_name => "User"
  # belongs_to :winner, :class_name => "User"
  # belongs_to :losser, :class_name => "User"
  # belongs_to :first_player, :class_name => "User"
  # belongs_to :secound_player, :class_name => "User"
  has_many :plots, :class_name => "GamePlot"

  after_create :create_game_plots

  def create_game_plots
    rows.times do |row|
      columns.times do |column|
        GamePlot.create game_id: self.id, vertical: column, horizontal: row
      end
    end
  end

  def won
    # returnerer en User record eller nil
    return winner if winner
    # check_horizontal
    # check_vertical
    check_back_slash
    # check_slash
  end

  def check_horizontal
    # beginning_time = Time.now
    # puts "#{caller(0)[0][55..-1]}:Elapsed #{(Time.now - beginning_time)*1000} msecs"

    rows.times do |j|
      line = plots.where(horizontal: j).order("vertical asc")
      # puts "========================================"
      # puts "========================================"
      # puts "========================================"
      user_with_row = check_list_for_winner line
      puts "user_with_row #{user_with_row.inspect}"
      if user_with_row
        return user_with_row
      end
    end
    return nil
  end

  def check_vertical
    # beginning_time = Time.now
    # puts "#{caller(0)[0][55..-1]}:Elapsed #{(Time.now - beginning_time)*1000} msecs"

    columns.times do |j|
      line = plots.where(vertical: j).order("horizontal asc")
      # puts "========================================"
      # puts "========================================"
      # puts "========================================"
      user_with_row = check_list_for_winner line
      puts "user_with_row #{user_with_row.inspect}"
      if user_with_row
        return user_with_row
      end
    end
    return nil
  end

  def check_back_slash
    # vertical = columns
    # horizontal = rows

    columns.times do |c|
      list=[]

      [columns,rows].min.times do |j|
        # list = plots.where(vertical: j).order("horizontal asc")
        list << plots.where(vertical: c+j).where(horizontal: j).first
        user_with_row = check_list_for_winner list
        # puts "user_with_row #{user_with_row.inspect}"
        if user_with_row
          return user_with_row
        end
      end
      # puts "=================="
    end

    rows.times do |r|
      list=[]
      [columns,rows].min.times do |j|
        # list = plots.where(vertical: j).order("horizontal asc")
        list << plots.where(vertical: j).where(horizontal: r+j).first

        user_with_row = check_list_for_winner list
        # puts "user_with_row #{user_with_row.inspect}"
        if user_with_row
          return user_with_row
        end
      end
      # puts "inspecting: #{list.inspect}"
    end
    return nil
  end

  def check_list_for_winner list
    # puts "===============++++++++++========================"
    # puts "elements #{list.inspect}"
    # puts "class of list in ewinner :#{list.class}"
    # puts "size of list in ewinner :#{list.size}"
    seleced_hash = {}
    list.each do |plot|
      return nil unless plot.class.to_s == "GamePlot"
      sele_by = plot.selected_by
      # puts "===============++++++++++========================"

      # puts "#{caller(0)[0][55..-1]}:plot id #{plot.id}"
      # puts "#{caller(0)[0][55..-1]}:selected_by #{sele_by.inspect}"
      # puts "#{caller(0)[0][55..-1]}:seleced_hash before #{seleced_hash}"
      # puts "#sele_by er no #{sele_by}"
      unless sele_by
        seleced_hash.map { |user_id, q| q = 0 }
        next
      end
      seleced_hash[sele_by.id] = 0 if seleced_hash[sele_by.id].nil?
      seleced_hash.map do |user_id, v|
        # puts "userEY #{user_id}"
        # puts "VALUE #{v}"
        # puts "sele_by.id #{sele_by.id}"
        if user_id == sele_by.id
          seleced_hash[user_id] += 1
          # puts"#{seleced_hash[user_id]} er _????#{length_to_win}"
          return User.where(id: user_id).first if seleced_hash[user_id] >= length_to_win
        else
          seleced_hash[user_id] = 0
        end
      end
      # puts "#{caller(0)[0][55..-1]}:seleced_hash after #{seleced_hash}"
      # puts seleced_hash.inspect
    end
    return nil
  end
end
