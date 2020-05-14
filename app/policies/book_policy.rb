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

  def destroy?
    record.user == user
  end
end
