require 'oystercard'

describe Oystercard do

  let(:card) { Oystercard.new }

  it 'has a balance of zero' do
    expect(card.balance).to eq 0
  end

  describe '#top_up' do
    context 'top up card' do
      it { is_expected.to respond_to(:top_up).with(1).argument }

      it 'will top up the balance by 5' do
        expect { card.top_up 5 }.to change { card.balance }.by 5
      end

      it 'throws an exception if new balance exceeds the limit' do
        card.top_up(Oystercard::CARD_LIMIT)
        expect { card.top_up 1 }.to raise_error "The limit is #{Oystercard::CARD_LIMIT}, you can not add more money to your oystercard!"
      end
    end
  end

  # describe '#deduct' do
  #   it { is_expected.to respond_to(:deduct).with(1).argument }

  #   it 'will deduct the fare of 5 from the balance' do
  #     expect { card.deduct 5 }.to change { card.balance }.by -5
  #   end
  # end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in) }

    it 'is initially not in a journey' do
      expect(card).not_to be_in_journey
    end

    it "can't touch-in if balance is less than minimum fare" do
      expect { card.touch_in }.to raise_error "No funds available"
    end 

    it 'starts the journey' do
      card.top_up(10)
      expect { card.touch_in }.to change { card.in_journey? }.to true
    end  
  end

  describe '#touch_out' do
    before(:each) do
      card.top_up(10)
      card.touch_in
    end

    it 'finishes the journey' do
      expect { card.touch_out }.to change { card.in_journey? }.to false
    end
  
    it 'deducts minimum fare' do
      expect { card.touch_out }.to change { card.balance }.by (-Oystercard::MINIMUM_FARE)
    end

  end
end