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
    record.user == user
  end

  def reserve?
    record.user != user
  end

  def unreserve?
    record.borrower_id == user.id
  end

  def destroy?
    record.user == user
  end
end
