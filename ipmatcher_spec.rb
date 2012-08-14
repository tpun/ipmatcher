require_relative './ipmatcher.rb'

describe 'Matcher' do
  subject { IPMatcher.new }

  describe '#add' do
    context 'when input does not contain wild card' do
      it 'adds given pattern' do
        subject.add '1.2.3.4'

        patterns = {'1' => {'2' => {'3' => {'4' => true}}}}
        subject.patterns.should == patterns
      end
    end

    context 'when input contains wild card' do
      it 'adds given pattern' do
        subject.add '2.4.*'

        patterns ={'2' => {'4' => {'*' => true}}}
        subject.patterns.should == patterns
      end
    end
  end

  describe '#match?' do
    before do
      subject.add '1.2.3.5'
      subject.add '1.2.4.5'
      subject.add '2.*'
      subject.add '2.3.*'
    end

    it 'matches 1.2.3.5' do
      subject.should be_match('1.2.3.5')
    end

    it 'does not match 1.2.3.4' do
      subject.should_not be_match('1.2.3.4')
    end

    it 'matches 2.1.2.3 with 2.*' do
      subject.should be_match('2.1.2.3')
    end

    it 'does not match anything less than 4 subnets' do
      subject.should_not be_match('1.2.3')
    end

    it 'does not match anything more than 4 subnets' do
      subject.should_not be_match('2.1.1.1.1.1')
    end
  end
end