
Loan = Data.define(:days_out, :student)

class Fees
  def calc(loan)
    days_late = loan.days_out - 14
    return 0 if days_late <= 0

    daily_rate = loan.student ? 0.10 : 0.25
    [days_late * daily_rate, 10.0].min
  end
end

class ReturnDesk
  def initialize
    @fees = Fees.new
  end

  def receipt(loan)
    "Late fine: $#{@fees.calc(loan)}"
  end
end
