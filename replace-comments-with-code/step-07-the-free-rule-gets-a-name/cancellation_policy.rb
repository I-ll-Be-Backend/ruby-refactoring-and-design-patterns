require "date"

Booking = Data.define(:check_in, :total, :nights, :rate, :loyal) do
  def loyal? = loyal
end

module CancellationPolicy
  FREE_CANCELLATION_DAYS = 14
  LAST_MINUTE_DAYS = 2
  NON_REFUNDABLE = "N"

  def self.fee(b, today)
    days_before_check_in = (b.check_in - today).to_i
    return 0 if free_cancellation?(days_before_check_in)
    # non-refundable or under 2 days out: pay in full
    return b.total if b.rate == NON_REFUNDABLE ||
                      days_before_check_in < LAST_MINUTE_DAYS
    # otherwise half the total
    f = b.total * 0.5
    # partner contracts require a one-night minimum
    [f, b.total / b.nights].max
  end

  private_class_method def self.free_cancellation?(days)
    days >= FREE_CANCELLATION_DAYS
  end
end
