require "oystercard"

describe Oystercard do
  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe "#balance" do
    it "has a default balance of 0 when intiliazed" do
      expect(subject.balance).to eq(0)
    end
    it "is incremented after top-up" do
      expect{ subject.top_up 1 }.to change { subject.balance }.by 1
    end
    it "raises an error if user attempts to top up the balance above £90" do
        subject.top_up Oystercard::MAXIMUM_BALANCE
        expect { subject.top_up 1 }.to raise_error "You have reached your top-up limit."
      end
    end

  end
