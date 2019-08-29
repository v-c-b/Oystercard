require 'oystercard'

describe Oystercard do
  let(:station) { double :station }
  let(:station2) { double :station }

  describe '#balance' do
    it 'has a default balance of 0 when intiliazed' do
      expect(subject.balance).to eq(0)
    end
    it 'is incremented after top-up' do
      expect { subject.top_up 1 }.to change { subject.balance }.by 1
    end
    it 'raises error balance attempted to cross max balance limit' do
      subject.top_up Oystercard::MAXIMUM_BALANCE
      expect { subject.top_up 1 }.to raise_error "You have reached your top-up limit of #{Oystercard::MAXIMUM_BALANCE}."
    end
    it 'touch in requires MINIMUM_AMOUNT_TO_TOUCH_IN balance' do
      expect { subject.touch_in(station) }.to raise_error "Failed - you do not have minimunm balance of #{Oystercard::MINIMUM_AMOUNT_TO_TOUCH_IN}."
    end
  end
  describe '#touchin and out?' do
    before :each do
      subject.top_up(Oystercard::MINIMUM_AMOUNT_TO_TOUCH_IN)
      subject.touch_in(station)
    end
  end
end
