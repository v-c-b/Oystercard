require "oystercard"

describe Oystercard do
  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe "#balance" do
    it "has a default balance of 0 when intiliazed" do
      expect(subject.balance).to eq(0)
    end
  end

end
