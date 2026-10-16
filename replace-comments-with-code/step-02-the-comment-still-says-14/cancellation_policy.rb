require "date"

Booking = Data.define(:check_in, :total, :nights, :rate, :loyal) do
  def loyal? = loyal
end

module CancellationPolicy
  def self.fee(b, today)
    # days left before check-in
    d = (b.check_in - today).to_i
    # free cancellation 14 days or more before check-in
    return 0 if d >= 14 || (b.loyal? && d >= 7)
    # non-refundable or under 2 days out: pay in full
    return b.total if b.rate == "N" || d < 2
    # otherwise half the total
    f = b.total * 0.5
    # partner contracts require a one-night minimum
    [f, b.total / b.nights].max
  end
end
