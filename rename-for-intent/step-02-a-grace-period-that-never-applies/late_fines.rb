
Loan = Data.define(:d, :f)

class Fees
  def calc(l)
    return 0 if l.d <= 3
    x = l.d - 14
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
