module Mutations
  # class Login
  #
  class Login < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true
    field :errors, String, null: false

    def resolve(email:, password:)
      user = User.find_for_authentication(email: email)

      if user.blank?
        respond_with('Auth error')
      else
        is_valid_for_auth = user.valid_for_authentication? {
          user.valid_password?(password)
        }

        is_valid_for_auth ? respond_with(user) : respond_with('Auth error')
      end
    end

    def respond_with(response)
      {
        user: response.is_a?(User) ? response : nil,
        errors: response.is_a?(String) ? response : ''
      }
    end
  end
end
