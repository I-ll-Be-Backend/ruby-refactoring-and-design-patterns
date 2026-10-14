
Loan = Data.define(:days_out, :student)

class Fees
  LOAN_DAYS = 14
  GRACE_DAYS = 3
  STUDENT_RATE = 0.10
  STANDARD_RATE = 0.25
  MAX_FINE = 10.0

  def overdue_fine(loan)
    days_late = loan.days_out - LOAN_DAYS
    return 0 if days_late <= GRACE_DAYS

    daily_rate = loan.student ? STUDENT_RATE : STANDARD_RATE
    [days_late * daily_rate, MAX_FINE].min
  end
end

class ReturnDesk
  def initialize
    @fees = Fees.new
  end

  def receipt(loan)
    "Late fine: $#{@fees.overdue_fine(loan)}"
  end
end
