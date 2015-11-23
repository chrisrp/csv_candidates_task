class Transaction
  include ActiveModel::Model
  include ActiveModel::Validations

  validate :umsatz_key_valid
  validate :transaction_valid

  def initialize(hash)
    new_hash = {}
    hash.map do |key, value|
      new_hash[key.downcase] = value
    end

    super new_hash
  end


  attr_accessor :activity_id,
                :depot_activity_id,
                :kontonummer,
                :amount,
                :currency,
                :entry_date,
                :value_date,
                :umsatz_key,
                :umsatz_key_ext,
                :receiver_blz,
                :receiver_konto,
                :receiver_name,
                :sender_blz,
                :sender_konto,
                :sender_name,
                :int_umsatz_key,
                :desc1,
                :desc2,
                :desc3,
                :desc4,
                :desc5,
                :desc6,
                :desc7,
                :desc8,
                :desc9,
                :desc10,
                :desc11,
                :desc12,
                :desc13,
                :desc14

  def transaction_type
    if sender_blz == '00000000' && receiver_blz == '00000000'
      'AccountTransfer'
    elsif sender_blz == '00000000' && umsatz_key == '10'
      'BankTransfer'
    elsif receiver_blz == '70022200' &&  umsatz_key == '16'
      'Lastschrift'
    end
  end

  def umsatz_key_valid
    message = "#{activity_id}: UMSATZ_KEY #{umsatz_key} is not allowed"
    errors.add(:UMSATZ, message) unless %w(10 16).include?(umsatz_key)
  end

  def transaction_valid
    errors.add(:base, "#{activity_id}: Transaction type not found") unless transaction_type
  end

end
