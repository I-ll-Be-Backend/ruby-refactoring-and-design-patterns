require "date"

Booking = Data.define(:check_in, :total, :nights, :rate, :loyal) do
  def loyal? = loyal
end

module CancellationPolicy
  FREE_CANCELLATION_DAYS = 14
  LOYALTY_FREE_DAYS = 7
  LAST_MINUTE_DAYS = 2
  NON_REFUNDABLE = "N"

  def self.fee(b, today)
    days_before_check_in = (b.check_in - today).to_i
    return 0 if free_cancellation?(b, days_before_check_in)
    return b.total if pays_in_full?(b, days_before_check_in)
    half_total = b.total * 0.5
    # partner contracts require a one-night minimum
    [half_total, nightly_price(b)].max
  end

  private_class_method def self.free_cancellation?(b, days)
    return days >= LOYALTY_FREE_DAYS if b.loyal?
    days >= FREE_CANCELLATION_DAYS
  end

  private_class_method def self.pays_in_full?(b, days)
    b.rate == NON_REFUNDABLE || days < LAST_MINUTE_DAYS
  end

  private_class_method def self.nightly_price(b)
    b.total / b.nights
  end
end
