
Loan = Data.define(:days_out, :f)

class Fees
  def calc(l)
    x = l.days_out - 14
    return 0 if x <= 0

    r = l.f ? 0.10 : 0.25
    [x * r, 10.0].min
  end
end

class ReturnDesk
  def initialize
    @fees = Fees.new
  end

  def receipt(l)
    "Late fine: $#{@fees.calc(l)}"
  end
end
