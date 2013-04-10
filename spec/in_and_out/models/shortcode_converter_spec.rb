require 'spec_helper'

describe InOrOut::ShortcodeConverter do

  let(:subject) { InOrOut::ShortcodeConverter }

  %i(fre ess nmfc syd melb wce
     gws stk gcfc bl geel carl
     rich wb coll haw port adel).each do |shortcode|
    it "returns the full team name for #{shortcode}" do
      subject.convert(shortcode).should_not == nil
    end
  end

  it 'returns a shortcode when a full name is given' do
    subject.find_shortcode('Essendon').should == 'ess'
  end

end