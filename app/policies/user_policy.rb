class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def edit?
    user == record
  end

  def update?
    user == record
  end

  def destroy?
    user == record
  end
end
