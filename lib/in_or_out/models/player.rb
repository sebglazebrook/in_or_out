module InOrOut
  class Player

    attr_reader :status, :position

    def initialize(player_name, team_name, status: nil, position: nil, number: nil)
      @name, @team = player_name, team_name
    end

  end
end