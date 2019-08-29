require "oystercard"

describe Oystercard do
  it { is_expected.to respond_to(:top_up).with(1).argument }
  it { is_expected.to respond_to(:in_journey?) }
  it { is_expected.to respond_to(:touch_in) }
  it {is_expected.to respond_to(:touch_out).with(1).argument}
  let(:station) { double :station }
  let(:station2) { double :station }

  describe '#default_behaviour' do
    it 'checks if the hash is empty by default' do
    expect(subject.journeys).to be_empty
    end
    end

  describe "#balance" do
    it "has a default balance of 0 when intiliazed" do
      expect(subject.balance).to eq(0)
    end
    it "is incremented after top-up" do
      expect { subject.top_up 1 }.to change { subject.balance }.by 1
    end
    it "raises an error if user attempts to top up the balance above max balance limit" do
      subject.top_up Oystercard::MAXIMUM_BALANCE
      expect { subject.top_up 1 }.to raise_error "You have reached your top-up limit of #{Oystercard::MAXIMUM_BALANCE}."
    end
    #    it "raises an error if user attempts to deduct to below the minimum balance requirement" do
    #      subject.top_up(-1*(Oystercard::MINIMUM_BALANCE)+subject.balance)
    #      expect { subject.deduct 1 }.to raise_error "Failed - you attempted to go below limit of #{Oystercard::MINIMUM_BALANCE}."
    #    end
    it "touch in requires MINIMUM_AMOUNT_TO_TOUCH_IN balance" do
      expect { subject.touch_in(station) }.to raise_error "Failed - you do not have minimunm balance of #{Oystercard::MINIMUM_AMOUNT_TO_TOUCH_IN}."
    end

  end
  describe "#touchin and out?" do
    before (:each) do
      subject.top_up(Oystercard::MINIMUM_AMOUNT_TO_TOUCH_IN)
      subject.touch_in(station)
    end
    it 'stores the journey in a hash' do
    subject.touch_out(station2)
    expect(subject.journeys[-1].journey).to eq({entry_station: station, exit_station: station2, complete: true})
    end

    it "entry station is nil after touch_out" do
      subject.touch_out(station)
      expect(subject.entry_station).to be nil
    end
    it "in_journey is true when touching in" do
      expect(subject.in_journey?).to be true
    end
    it "in_journey is false when touching out" do
      subject.touch_out(station)
      expect(subject.in_journey?).to be false
    end
  end
end
