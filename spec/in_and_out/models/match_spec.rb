require 'spec_helper'
require 'ostruct'
require 'nokogiri'

describe InOrOut::Match do

  let(:round) { 2 }
  let(:team_name) { 'Essendon' }
  let(:subject) { InOrOut::Match.new(team_name, round)}

  describe 'initialize' do

    before do
      extracted_players = [ OpenStruct.new(name: 'Gary Ablett', team: 'Gold Coast') ]
      InOrOut::PlayerExtractor.any_instance.should_receive(:extract).at_least(1).times.and_return(extracted_players)
    end

    let(:scraper_response) { File.open("#{InOrOut.root}/spec/data/finialised_teams.html").read }

    it 'takes a team name a match round and populates the match' do
      InOrOut::Scraper.any_instance.should_receive(:scrape).and_return(scraper_response)
      subject.players.size.should == 1
    end

  end

  describe 'find' do

    let(:afl_schedule_response) { OpenStruct.new(home_team: 'Essendon',
                                                 away_team: 'Melbourne',
                                                 venue: 'MCG',
                                                 time: Time.new(2013, 04, 6, 19, 40, 0, '+10:00'),
                                                 round: 2) }
    let(:subject) { InOrOut::Match.find(team: team_name)}

    it 'returns the next match for the given team name' do
      AFL::Schedule.any_instance.should_receive(:next_match).with('').and_return(afl_schedule_response)
      subject.class.should == InOrOut::Match
    end

    let(:team_name) { '' }

    it 'returns "nil" if no match was found' do
      AFL::Schedule.any_instance.should_receive(:next_match).with('').and_return(nil)
      subject.should == nil
    end

  end

  describe 'finding a player' do

    context 'player does not exit' do

    before do
      extracted_players = [ OpenStruct.new(name: 'Gary Ablett', team: 'Gold Coast') ]
      InOrOut::PlayerExtractor.any_instance.should_receive(:extract).at_least(1).times.and_return(extracted_players)
    end

    it "returns 'nil' if the player can't be found" do
      InOrOut::Scraper.any_instance.should_receive(:scrape).and_return('')
      subject.find_player('Jobe Watson', 'Essendon').should == nil
    end

    end

    context 'player exists' do

      before do
        extracted_players = [ OpenStruct.new(name: 'Gary Ablett', team: 'Gold Coast') ]
        InOrOut::PlayerExtractor.any_instance.should_receive(:extract).at_least(1).times.and_return(extracted_players)
      end

      it 'returns the player' do
        scraper_response = File.open("#{InOrOut.root}/spec/data/finialised_teams.html").read
        InOrOut::Scraper.any_instance.should_receive(:scrape).and_return(scraper_response)
        player = subject.find_player('Gary Ablett', 'Gold Coast')
        player.name.should == 'Gary Ablett'
        player.team.should == 'Gold Coast'
      end

    end
  end

end