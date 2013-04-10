require 'spec_helper'

describe InOrOut do

  describe 'Player' do

    context 'match is ready' do

      let(:data) { File.open("#{InOrOut.root}/spec/data/finialised_teams.html") }
      let(:team_name) { 'Gold Coast' }
      let(:player_name) { 'Gary Ablett' }
      let(:subject) { InOrOut::Player.new(player_name, team_name) }
      before do
        InOrOut::Scraper.any_instance.should_receive(:scrape).and_return(data)
      end

      context 'player is playing' do

        it 'has a full set of player attributes ' do
          subject.name.should == 'Gary Ablett'
          subject.team.should == 'Gold Coast'
          subject.position.should == 'Centre'
          subject.status.should == 'On'
          subject.number.should == 9
        end

      end

    end

    context 'match is not ready/found' do

      let(:team_name) { 'Essendon' }
      let(:player_name) { 'Jobe Watson' }
      let(:subject) { InOrOut::Player.new(player_name, team_name) }

      before do
        InOrOut::Match.should_receive(:find).at_least(1).times.and_return(nil)
      end

      it 'status is set to "unknown"' do
        subject.status.should == 'Unknown'
      end

    end

  end

end