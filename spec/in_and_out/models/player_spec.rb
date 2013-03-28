require 'spec_helper'
require 'ostruct'

describe InOrOut::Player do

  let(:player_name) { 'Jobe Watson' }
  let(:team_name) { 'Essendon' }
  let(:analyser_response) { OpenStruct.new(position: 'Centre', status: 'In') }

  before do
    InOrOut::Analyser.any_instance.should_receive(:analyse).and_return(analyser_response)
  end

  describe 'initialize' do

    let(:subject) { InOrOut::Player }

    it 'takes a player name and a team name' do
      subject.new(player_name, team_name).class.should == InOrOut::Player
    end

    it 'analyses the player and sets their status and position' do
      player = subject.new(player_name, team_name)
      player.status.should == analyser_response.status
      player.position.should == analyser_response.position
    end

  end

  describe 'attributes' do

    let(:subject) { InOrOut::Player.new(player_name, team_name)}

    %i(status position).each do |attribute|
      it "has a #{attribute}" do
        subject.respond_to?(attribute).should == true
      end
    end

  end

end