require 'in_or_out/version'
require 'in_or_out/models/analyser'
require 'in_or_out/models/player'
require 'in_or_out/models/scraper'
require 'in_or_out/models/team'
require 'in_or_out/models/match'

require 'yaml'
require 'active_support/core_ext/hash/indifferent_access'

module InOrOut


  def self.root
    File.expand_path '../..', __FILE__
  end

  def self.config
    HashWithIndifferentAccess.new(YAML.load(File.read("#{self.root}/config/analyser.yml")))
  end

end
