module Mutations
  # class Login
  #
  class Logout < BaseMutation
    type Boolean

    def resolve
      if context[:current_user]
        context[:current_user].update(jti: SecureRandom.uuid)
        true
      else
        false
      end
    end
  end
end
