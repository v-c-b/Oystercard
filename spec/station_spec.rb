require 'station'

describe Station do
  describe '#exposes' do
    it 'name' do
      is_expected.to respond_to(:name)
    end
    it 'zone' do
      is_expected.to respond_to(:zone)
    end
  end

  describe '#default behaviour' do
    it 'has default name Central Station' do
      expect(subject.name).to eq('Central Station')
    end
    it 'has default zone of 1' do
      expect(subject.zone).to eq(1)
    end
  end
end
