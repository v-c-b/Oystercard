require "oystercard"

describe Oystercard do
  describe "#balance" do
    it "has a default balance of 0 when intiliazed" do
      expect(subject.balance).to eq(0)
    end
  end

end
