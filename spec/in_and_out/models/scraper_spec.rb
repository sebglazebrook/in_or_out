require 'spec_helper'

describe InOrOut::Scraper do

  describe 'scrape' do

    context 'found url' do

      it 'returns the urls html as a string' do
        subject.scrape('http://www.google.com').class.should == String
      end

    end

  end

end