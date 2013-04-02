module InOrOut
  class Player

    attr_reader :number, :position

    def initialize(player_name, team_name,  **options)
      @name, @team = player_name, team_name
      @number, @position = options[:number], options[:position]
    end

  end
end