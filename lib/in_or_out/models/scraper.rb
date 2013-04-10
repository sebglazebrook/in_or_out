require 'mechanize'

module InOrOut
  class Scraper

    def scrape(url)
      a = Mechanize.new { |agent|
        agent.user_agent_alias = 'Mac Safari'
      }

      a.get(url).content
    end

  end
end