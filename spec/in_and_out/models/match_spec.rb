require 'spec_helper'
require 'ostruct'

describe InOrOut::Match do

  context 'match data can not be found' do

    let(:data) { 'No match data here' }
    let(:subject) { InOrOut::Match.new(data) }

    it 'marks the match as "pending"' do
      subject.status.should == 'pending'
    end

    it 'player status calls come back as "Unknown" ' do
      subject.playing_status('Seb G', 'Test team').should == 'Unknown'
    end

  end

  context 'match data can be found' do

      let(:data) { File.open("#{InOrOut.root}/spec/data/finialised_teams.html") }
      let(:subject) { InOrOut::Match.new(data)}

      it 'knows if a player is playing' do
        player_response = OpenStruct.new(name: 'Gary Ablett', team: 'Gold Coast Suns', playing_status: 'On')
        InOrOut::Player.stub(:new).and_return(player_response)
        subject.playing_status('Gary Ablett', 'Gold Coast Suns').should == 'On'
      end

      it 'knows if a player is not playing' do
        player_response = OpenStruct.new(name: 'Gary Ablett', team: 'Gold Coast Suns', playing_status: 'On')
        InOrOut::Player.stub(:new).and_return(player_response)
        subject.playing_status('Tony Lockett', 'St Kilda').should == 'Off'
      end

  end

end