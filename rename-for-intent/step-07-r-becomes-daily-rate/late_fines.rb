
Loan = Data.define(:days_out, :student)

class Fees
  def calc(l)
    days_late = l.days_out - 14
    return 0 if days_late <= 0

    daily_rate = l.student ? 0.10 : 0.25
    [days_late * daily_rate, 10.0].min
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
