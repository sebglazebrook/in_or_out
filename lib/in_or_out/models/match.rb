require 'nokogiri'
require 'active_support/inflector'

module InOrOut
  class Match

    attr_reader :status

    def initialize(data)
      @data = Nokogiri::HTML(data)
      @players = extract_players
      @players.empty? ? @status = 'pending' : @status = 'ready'
    end

    def playing_status(player_name, team_name)
      player = @players.detect { |player| player.name == player_name && player.team == team_name }
      if player
        player.playing_status
      else
        @status == 'ready' ? 'Off' : 'Unknown'
      end
    end

    private

    def extract_players
      @players = @data.css('.player').map do |player|
        build_player(
            player.inner_text.split.last,
            extract_team(player),
            '',
            extract_position(player),
            player.inner_text.split.first
        )
      end
    end

    def build_player(name, team, status, position, number )
      InOrOut::Player.new(name, team, status: status, position: position, number: number)
    end

    def extract_team(player_html_doc)
      ""
    end

    def extract_number(player_html_doc)

    end

    def extract_position(player_html_doc)
      player_html_doc.ancestors('div').first.attr('class').split.last.singularize
    end

  end
end
