module PunditTestHelpers
  def assert_permit(user, record, actions)
    actions = Array(actions)

    actions.each do |action|
      msg = "User #{user.inspect} should be permitted to #{action} #{record}, but isn't permitted."
      assert Pundit.policy(user, record).public_send(action), msg
    end
  end

  def refute_permit(user, record, actions)
    actions = Array(actions)

    actions.each do |action|
      msg = "User #{user.inspect} should NOT be permitted to #{action} #{record}, but is permitted."
      assert_not Pundit.policy(user, record).public_send(action), msg
    end
  end
end
