module InOrOut
  class Player

    attr_reader :number, :position, :name, :team

    def initialize(player_name, team_name,  **options)
      @name, @team = player_name, team_name
      @number, @position, @status = options[:number], options[:position], options[:status]
    end

    def position
      analyse unless @position
      @position
    end

    def number
      analyse unless @number
      @number
    end

    def status
      evaluate_status unless @status
      @status
    end

    private

    def analyse
      if next_match
        populate_match_attributes
      else
        @status = 'Unknown'
      end
      self
    end

    def next_match
      @match = InOrOut::Match.find(team: @team)
    end

    def populate_match_attributes
      player = @match.find_player(@name,@team)
      if player
        @status = player.status
        @position = player.position
        @number = player.number
      else
        @status = 'Off'
      end
    end

    def evaluate_status
      if position == 'Follower' || position == 'Centre' || position == 'Full Back' #@TODO add all positions
        @status = 'On'
      else
        @status = 'Unknown'
      end
    end

  end
end