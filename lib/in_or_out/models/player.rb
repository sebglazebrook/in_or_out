module InOrOut
  class Player

    attr_reader :status, :position

    def initialize(player_name, team_name)
      @name, @team = player_name, team_name
      analysis = Analyser.new(@team, @name).analyse
      puts analysis.inspect
      @status, @position = analysis.status, analysis.position
    end

  end
end