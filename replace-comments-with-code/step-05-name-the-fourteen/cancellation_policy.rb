require "date"

Booking = Data.define(:check_in, :total, :nights, :rate, :loyal) do
  def loyal? = loyal
end

module CancellationPolicy
  FREE_CANCELLATION_DAYS = 14

  def self.fee(b, today)
    days_before_check_in = (b.check_in - today).to_i
    # free cancellation 14 days or more before check-in
    return 0 if days_before_check_in >= FREE_CANCELLATION_DAYS
    # non-refundable or under 2 days out: pay in full
    return b.total if b.rate == "N" || days_before_check_in < 2
    # otherwise half the total
    f = b.total * 0.5
    # partner contracts require a one-night minimum
    [f, b.total / b.nights].max
  end
end
