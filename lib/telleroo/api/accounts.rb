module Telleroo
  module API
    # Telleroo Accounts. These are Bank Accounts
    module Accounts
      # The default name of the bank account is primary account, which is
      # accessible through a unique id. Your account number and sort code
      # are returned here as well. All bank accounts linked to your
      # company are returned with this request.

      # Returns bank accounts list
      # @return [Array]
      def accounts
        get('accounts')
      end
    end
  end
end
