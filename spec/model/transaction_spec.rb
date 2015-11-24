require 'spec_helper'

RSpec.describe Transaction do
  let(:activity_id) { '01' }
  let(:amount) { '5' }
  let(:kontonummer) { '000001' }

  let(:data) do
    { 'ACTIVITY_ID' => activity_id,
      'DEPOT_ACTIVITY_ID' => "",
      'AMOUNT' => amount,
      'UMSATZ_KEY' => "10",
      'ENTRY_DATE' => Time.now.strftime('%Y%m%d'),
      'KONTONUMMER' => kontonummer,
      'RECEIVER_BLZ' => '00000000',
      'RECEIVER_KONTO' => '000000002',
      'RECEIVER_NAME' => 'Mustermann',
      'SENDER_BLZ' => '00000000',
      'SENDER_KONTO' => '000000003',
      'SENDER_NAME' => 'Mustermann',
      'DESC1' => "Geld senden" }
  end

  describe '#initialize' do
    subject { Transaction.new(data) }

    it { expect(subject.activity_id).to eq activity_id }
    it { expect(subject.amount).to eq amount }
    it { expect(subject.kontonummer).to eq kontonummer }
  end

  #TODO: test transaction_type
end
