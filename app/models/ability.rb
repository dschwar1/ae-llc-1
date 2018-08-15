class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # not logged in
    if user.role? :admin
      can :manage, :all
    elsif user.role? :foreman
      can [:home], :home
    else
      can [:home], :home
    end
  end
end
