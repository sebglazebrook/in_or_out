module InOrOut
  class PlayerExtractor

    def initialize(match_data)
      @data = match_data
    end

    def extract
      @data.css('.player').map do |player|
        build_player(
            extract_name(player),
            extract_team(player),
            extract_position(player),
            extract_number(player)
        )
      end
    end

    private

    def build_player(name, team, position, number )
      InOrOut::Player.new(name, team, position: position, number: number)
    end

    def extract_name(player_html_doc)
      player_html_doc.inner_text[(player_html_doc.inner_text.rindex(/\d/)+1)..player_html_doc.inner_text.size].strip!.gsub(/\u00a0/, ' ')
    end

    def extract_team(player_html_doc)
      InOrOut::ShortcodeConverter.convert(player_html_doc.ancestors('ul').first.attr('class').split.last.split('-').last)
    end

    def extract_number(player_html_doc)
      player_html_doc.inner_text[(player_html_doc.inner_text.index(/\d/))..(player_html_doc.inner_text.rindex(/\d/))].to_i
    end

    def extract_position(player_html_doc)
      player_html_doc.ancestors('div').first.attr('class').split.last.singularize.capitalize
    end

  end
end