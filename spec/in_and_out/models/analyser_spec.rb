require 'spec_helper'
require 'ostruct'

describe InOrOut::Analyser do

  let(:player_name) { 'Jobe Watson' }
  let(:team_name) { 'Essendon' }

  describe 'initializer' do

    let(:subject) { InOrOut::Analyser }

    it 'takes a team and an optional player' do
      subject.new(team_name).class.should == InOrOut::Analyser
      subject.new(team_name, player_name).class.should == InOrOut::Analyser
    end

  end

  describe 'analyse' do

    let(:subject) { InOrOut::Analyser.new(team_name, player_name) }

    before do
      InOrOut::Match.any_instance.should_receive(:playing_status).with(player_name, team_name).and_return('On')
      InOrOut::Match.any_instance.should_receive(:position).with(player_name, team_name).and_return('Centre')
    end

    it 'returns the players playing status' do
      subject.analyse.status.should == 'On'
    end

    it 'returns the players position' do
      subject.analyse.position.should == 'Centre'
    end

  end

  describe 'url' do

    let(:subject) { InOrOut::Analyser.new(team_name, player_name) }
    let(:afl_schedule_response) { OpenStruct.new(home_team: 'Essendon',
                                                 away_team: 'Melbourne',
                                                 venue: 'MCG',
                                                 time: Time.new(2013, 04, 6, 19, 40, 0, '+10:00'),
                                                 round: 2) }


    it 'returns the url for the next round' do
      AFL::Schedule.any_instance.should_receive(:next_match).with('Essendon').and_return(afl_schedule_response)
      InOrOut::Team.should_receive(:new).with('Essendon').and_return(OpenStruct.new(short_code: 'ess'))
      InOrOut::Team.should_receive(:new).with('Melbourne').and_return(OpenStruct.new(short_code: 'melb'))
      subject.send(:url).should == 'http://www.afl.com.au/match-centre/2013/2/ess-v-melb'
    end

  end

end