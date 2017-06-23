module Telleroo
  module API
    # Telleroo Recipients. These are Bank Accounts that receive funds
    module Recipients
      # Return all Recipients associated to your account

      # {
      #   "recipients": [
      #     {
      #       "id": "ff17b231-2bc4-485e-967e-231867e15fd6",
      #       "name": "John Archer",
      #       "currency_code": "GBP",
      #       "account_no": "12345678",
      #       "sort_code": "123456",
      #       "legal_type": "PRIVATE"
      #     },
      #     {
      #       "id": "1fdfef97-95b8-4985-917a-5d9ac9d52d35",
      #       "name": "Antonio Silva",
      #       "currency_code": "EUR",
      #       "iban": "12345678901234567",
      #       "bic": "12345678901",
      #       "legal_type": "PRIVATE"
      #     }
      #   ]
      # }

      # @return [Array]
      def recipients
        get('recipients')
      end

      # This endpoint retrieves a single recipient by entering the recipient_id

      # @param [String] id The Telleroo ID of the Recipient
      # @return [Hash]
      def get_recipient(id)
        get("recipients/#{id}")
      end

      # This creates a new recipient. Telleroo gives you back a unique
      # recipient_id that can be referenced when creating a bank transfer.

      # @param [String] name The name of the Account Holder
      # @param [String] currency_code Currency of Account
      # @param [Hash] options Optional Account Detail

      # {
      #   "recipient": {
      #     "id": "ff17b231-2bc4-485e-967e-231867e15fd6",
      #     "name": "Jefke Vermeulen",
      #     "currency_code": "GBP",
      #     "account_no": "12345678",
      #     "sort_code": "224657",
      #     "legal_type": "PRIVATE"
      #   }
      # }

      # @return [Hash]

      def create_recipient(name: nil, currency_code: nil, options: {})
        params = {
          name: name,
          currency_code: currency_code
        }.merge(options)

        post('recipients', params)
      end

      # This removes a recipient. Removing a recipient means you
      # can no longer use their recipient ID.

      # @param [String] id The Telleroo ID of the Recipient
      def delete_recipient(id)
        delete("recipients/#{id}")
      end
    end
  end
end
