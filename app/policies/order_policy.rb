class OrderPolicy < ApplicationPolicy
  class Scope < OrderPolicy
    def resolve
      if user.admin? || user.owner?
        Order.all
      else
        Order.where(customer_id: user.id)
      end
    end
  end
  
  def show?
    user.admin? || (record.customer_id == user.id)
  end
end
