require 'spec_helper'
require 'nokogiri'

describe InOrOut::PlayerExtractor do


  let(:match_data) { Nokogiri::HTML(File.open("#{InOrOut.root}/spec/data/finialised_teams.html").read) }
  let(:subject) { InOrOut::PlayerExtractor.new(match_data).extract }

  describe 'extraction process' do

    it 'takes match data and returns a collection of players' do
      subject.size.should == 50
      subject.first.class.should == InOrOut::Player
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

  end

end