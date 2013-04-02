require 'ostruct'
require 'afl_schedule'

module InOrOut
  class Analyser

    def initialize(team, player = nil)
      @team, @player = team, player
      @scraper = Scraper.new
    end

    def analyse
      extract_info(match)
    end

    private

    def match
      @match || @match = InOrOut::Match.new(data)
    end

    def data
      @scraper.scrape(url)
    end

    def extract_info(match)
      if match == 'An error occurred'
        match
      else
        OpenStruct.new(status: match.playing_status(@player, @team), position: match.position(@player, @team))
      end
    end

    def url
      next_match = AFL::Schedule.new.next_match(@team)
      "#{InOrOut.config[:afl_match_data_url]}/#{Time.now.year}/#{next_match.round}/#{opponents_short_code(next_match.home_team, next_match.away_team)}"
    end

    def opponents_short_code(home_team, away_team)
      "#{InOrOut::Team.new(home_team).short_code}-v-#{InOrOut::Team.new(away_team).short_code}"
    end

  end
end