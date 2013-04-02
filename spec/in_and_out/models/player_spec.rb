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

  end

end