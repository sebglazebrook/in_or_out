require 'spec_helper'
require 'ostruct'

describe InOrOut::Player do

  let(:player_name) { 'Jobe Watson' }
  let(:team_name) { 'Essendon' }
  let(:analyser_response) { OpenStruct.new(position: 'Centre', status: 'In') }

  describe 'initialize' do

    let(:subject) { InOrOut::Player }

    it 'requires a player and team name' do
      subject.new(player_name, team_name).class.should == InOrOut::Player
    end

    %w(number position).each do |attr|
      it "accepts '#{attr}' as an optional attribute" do
        subject.new(player_name, team_name, attr.to_sym => 'attribute value').send(attr.to_sym).should == 'attribute value'
      end

    end

    it 'sets a status' do
      subject.new(player_name, team_name, :position => 'Follower').status.should == 'On'
    end

  end

  describe 'analyse' do

    let(:subject) { InOrOut::Player.new(player_name, team_name)  }

    context 'next match not found' do

      before do
        InOrOut::Match.should_receive(:find).and_return(nil)
      end

      it "returns itself with the a status of 'Unknown'" do
        subject.send(:analyse).status.should == 'Unknown'
      end

    end

    context 'next match found' do

      let(:match_double) { double('Match') }
      let(:player_double) { double('Player') }

      context 'player is playing' do

        before do
          InOrOut::Match.should_receive(:find).with(team: team_name).and_return(match_double)
          match_double.should_receive(:find_player).with(player_name,team_name).and_return(player_double)
          player_double.should_receive(:status).and_return('On')
          player_double.should_receive(:position).and_return('Centre')
          player_double.should_receive(:number).and_return(4)
        end

        it 'returns itself with status set to "On"' do
          subject.send(:analyse).status.should == 'On'
        end

        it 'has a "position" and a "number"'   do
          player = subject.send(:analyse)
          player.position.should == 'Centre'
          player.number.should == 4
        end

      end

    end

  end

end