class BookPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def new?
    record.user == user
  end

  def create?
    record.user == user
  end

  def edit?
    record.user == user
  end

  def update?
    !user.nil?
  end

  def show_reservation_btn?
    (record.borrower.nil? || record.borrower == user) && record.user != user
  end

  def destroy?
    record.user == user
  end
end
