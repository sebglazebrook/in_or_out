require 'nokogiri'
require 'active_support/inflector'
require 'afl_schedule'

module InOrOut
  class Match

    attr_reader :status, :players

    def initialize(home_team, round, away_team = nil)
      @home_team, @away_team, @round = home_team, away_team, round
      @players = InOrOut::PlayerExtractor.new(download_match_data).extract
      @players.empty? ? @status = 'pending' : @status = 'ready'
    end

    def find_player(player_name, team_name)
      @players.detect { |player| player.name == player_name && player.team == team_name }
    end

    def self.find(**options)
      match = AFL::Schedule.new.next_match(options[:team])
      if match
        self.new(match[:home_team], match[:round], match[:away_team])
      else
        match
      end
    end

    private

    def download_match_data
      Nokogiri::HTML(InOrOut::Scraper.new.scrape(match_url))
    end

    def match_url
      next_match = AFL::Schedule.new.next_match(@home_team) unless @away_team
      "#{InOrOut.config[:afl_match_data_url]}/#{Time.now.year}/#{@round}/#{opponents_short_code(@home_team, @away_team)}"
    end

    def opponents_short_code(home_team, away_team)
      "#{InOrOut::Team.new(home_team).short_code}-v-#{InOrOut::Team.new(away_team).short_code}"
    end

  end
end
