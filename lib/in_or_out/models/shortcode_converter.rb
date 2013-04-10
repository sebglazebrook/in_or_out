require 'yaml'
require 'active_support/core_ext/hash/indifferent_access'

module InOrOut
    class ShortcodeConverter

      def self.convert(shortcode)
        shortcodes[shortcode]
      end

      def self.find_shortcode(team_name)
        shortcodes.key(team_name)
      end

      private

      def self.shortcodes
        HashWithIndifferentAccess.new(YAML.load(File.read("#{InOrOut.root}/data/team_shortcode_data.yml")))
      end
  end
end