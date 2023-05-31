class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Recipe, public: true

    return unless user.present? # additional permissions for logged in users (they can read their own posts)

    can :read, :create, :destroy
  end
end
