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
      res = player_html_doc.ancestors('div').first.attr('class').split.last.singularize.capitalize
      if res == 'Posgroup'
        res = convert_position_shorthand(player_html_doc.ancestors('ul').css('.pos').first.inner_text.strip)
      end
      res = check_if_emergency(player_html_doc) if res == 'Interchange'
      res
    end

    def convert_position_shorthand(position)
      case position
        when 'HB'
          'Half Back'
        when 'HF'
          'Half Forward'
        when 'FF'
          'Full Forward'
        when 'FB'
          'Full Back'
        when 'C'
          'Centre'
      end
    end

    def check_if_emergency(player_html_doc)
      positions = player_html_doc.ancestors('ul').first.css('.pos').size
      if positions > 1
        res = nil
        while res == nil
          previous = player_html_doc.previous_element
          if previous.attr('class') == 'pos'
            res = previous.inner_text.singularize.strip
          else
            player_html_doc = previous
          end
        end
      else
        res = 'Interchange'
      end
      res
    end

  end
end