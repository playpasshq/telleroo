module Telleroo
  module API
    # Telleroo Transfers. These are bank transfers from your
    # Source Account to Recipient
    module BankTransfers
      # This triggers an instantaneous bank transfer to a existing recipient -
      # Faster Payments per default - out of your primary account.
      # Telleroo gives you back a unique transfer_id that can be referenced on
      # the statement.
      # The default currency is GBP and the format is pence (100 equals 1 GBP).
      # All transfers are approved per default and are directly placed into
      # the payments scheme after passing through validation
      # (e.g. sufficient account balance).

      # Instructs bank transfer to a saved recipient

      # @param [String] account_id Telleroo ID of the Source Account
      # @param [String] currency_code Currency of Account
      # @param [Integer] amount The Amount in cents of the transfer
      # @param [String] idempotent_key Unique key for each transaction
      # @param [Hash] options Optional Detail

      # {
      #   "bank_transfer": {
      #     "id": "842963c5-e230-42ef-8de8-2b7a459026",
      #     "processed_at": "2016-12-02T12:15:22.486Z",
      #     "transaction_type": "Debit",
      #     "currency_code": "GBP",
      #     "amount": 100,
      #     "recipient_id": "ff17b231-2bc4-485e-967e-231867e15fd6",
      #     "status": "Preparing Payment",
      #     "status_info": "Creating payment request",
      #     "reconciliation": "f9q3408rh3",
      #     "reference": "PayslipDec16",
      #     "account_id": "ed5af7d2-741c-4905-a3ba-66d332d604",
      #     "tag": "Payroll",
      #     "end_balance": 2100,
      #     "idempotent_key": "2130948",
      #     "created_at": "2017-3-08T13:15:32.237Z",
      #     "updated_at": "2017-3-08T13:15:32.237Z"
      #   }
      # }

      # @return [Hash]
      def create_transfer(account_id: nil, currency_code: nil, amount: nil, recipient_id: nil, idempotent_key: nil, options: {})
        params = {
          account_id: account_id,
          currency_code: currency_code,
          amount: amount,
          recipient_id: recipient_id,
          idempotent_key: idempotent_key
        }.merge(options)

        post('bank_transfers', params)
      end
    end
  end
end
