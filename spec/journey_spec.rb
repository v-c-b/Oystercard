require 'journey'

describe Journey do
  let(:station) {double :station }

  describe 'journey start' do
    it 'stores the entry_station' do
    subject.start(station)
  expect(subject.entry_station).to eq(station)
  end
end

end
