require 'oystercard'

describe Oystercard do
  let(:card) { Oystercard.new }

  it 'has a balance of zero' do
    expect(card.balance).to eq 0
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'will top up the balance by 5' do
      expect { card.top_up 5 }.to change { card.balance }.by 5
    end

    it 'throws an exception if new balance exceeds the limit' do
      card.top_up(Oystercard::CARD_LIMIT)
      expect { card.top_up 1 }.to raise_error "The limit is #{Oystercard::CARD_LIMIT}, can not add more money on your oystercard!"
    end
  end
end