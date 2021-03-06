require 'spec_helper'
require 'nokogiri'

describe InOrOut::PlayerExtractor do

  describe 'match readyness' do

    let(:subject) { InOrOut::PlayerExtractor.new(match_data).send(:ready?) }

    context 'match data not complete' do

      let(:match_data) { Nokogiri::HTML("<html></html>") }

      it "match as 'not ready'" do
        subject.should == false
      end

    end

    context 'match data complete' do

      let(:match_data) { Nokogiri::HTML(File.open("#{InOrOut.root}/spec/data/finialised_teams.html").read) }

      it "match is 'ready'" do
        subject.should == true
      end

    end

  end


  let(:match_data) { Nokogiri::HTML(File.open("#{InOrOut.root}/spec/data/finialised_teams.html").read) }
  let(:subject) { InOrOut::PlayerExtractor.new(match_data).extract }

  describe 'extraction process' do

    it 'takes match data and returns a collection of players' do
      subject.size.should == 50
      subject.first.class.should == InOrOut::Player
    end

    it 'only extracts data if match is ready' do
      InOrOut::PlayerExtractor.any_instance.should_receive(:ready?).and_return(false)
      subject.empty?.should == true
    end

  end

  describe 'attributes extracted' do

    before do
      InOrOut::ShortcodeConverter.should_receive(:convert).at_least(1).times.with('stk').and_return('St Kilda')
      InOrOut::ShortcodeConverter.should_receive(:convert).at_least(1).times.with('gcfc').and_return('Gold Coast')
    end

    %i(name team position number).each do |extracted_attribute|
      it "extracts a #{extracted_attribute}" do
        subject.first.send(extracted_attribute).should_not be nil
      end
    end

    describe 'position' do

      let(:subject) { InOrOut::PlayerExtractor.new(match_data).extract }

      describe 'Followers' do

        it 'can be found' do
          subject.detect { |player| player.position  == 'Follower'}.should_not == nil
        end

      end

      describe 'Full Backs' do

        it 'can be found' do
          subject.detect { |player| player.position  == 'Full Back'}.should_not == nil
        end

      end

      describe 'Full Forwards' do

        it 'can be found' do
          subject.detect { |player| player.position  == 'Full Forward'}.should_not == nil
        end

      end

      describe 'Half Forwards' do

        it 'can be found' do
          subject.detect { |player| player.position  == 'Half Forward'}.should_not == nil
        end

      end

      describe 'Half backs' do

        it 'can be found' do
          subject.detect { |player| player.position  == 'Half Back'}.should_not == nil
        end

      end

      describe 'Centre' do

        it 'can be found' do
          subject.detect { |player| player.position  == 'Centre'}.should_not == nil
        end

      end

      describe 'Interchange' do

        it 'can be found' do
          subject.detect { |player| player.position  == 'Interchange'}.should_not == nil
        end

      end

      describe 'Emergencies' do

        it 'can be found' do
          subject.detect { |player| player.position  == 'Emergency'}.should_not == nil
        end

      end

    end

  end

end