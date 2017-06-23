module Telleroo
  module API
    # Telleroo Accounts. These are Bank Accounts
    module Transactions
      # This returns all activity on a specified bank account.

      # Returns transaction overview

      # @param [String] account_id Telleroo ID of the Source Account
      # @param [Date] start_date Filetr results by start date (DD-MM-YYYY)
      # @param [Date] end_date Filter results by end date (DD-MM-YYYY)
      # @param [Integer] page pagination

      # {
      #   "transactions": [
      #     {
      #       "id": "842963c5-e230-42ef-8de8-2b7a459026",
      #       "processed_at": "2016-12-01T12:15:23.486Z",
      #       "transaction_type": "Credit",
      #       "currency_code": "GBP",
      #       "amount": "1000",
      #       "recipient_id": null,
      #       "status": "Credited",
      #       "status_info": "Funds successfully credited",
      #       "reconciliation": "3456yujk",
      #       "reference": "Funding Telleroo",
      #       "account_id": "ed5af7d2-741c-4905-a3ba-66d332d604",
      #       "tag": "Sponsoring",
      #       "end_balance": 1560,
      #       "created_at": "2016-12-01T12:15:22.486Z",
      #       "updated_at": "2016-12-01T12:15:22.486Z"
      #     },
      #     {
      #       "id": "842963c5-e230-42ef-8de8-2b7a459026",
      #       "processed_at": "2016-12-01T12:15:23.486Z",
      #       "transaction_type": "Debit",
      #       "currency_code": "GBP",
      #       "amount": "100",
      #       "recipient_id": "122963c5-e230-42ef-8de8-327459026",
      #       "status": "Preparing Payment",
      #       "status_info": "Creating payment request",
      #       "reconciliation": "f9q3408rh3",
      #       "reference": "Withdrawal Telleroo",
      #       "account_id": "ed5af7d2-741c-4905-a3ba-66d332d604",
      #       "tag": "Manutd",
      #       "end_balance": 1460,
      #       "idempotent_key": "6130348",
      #       "created_at": "2016-12-01T12:15:22.486Z",
      #       "updated_at": "2016-12-01T12:15:22.486Z"
      #     }
      #   ]
      # }

      # @return [Array]
      def transactions(account_id: nil, start_date: nil, end_date: nil, page: 1)
        params = {
          account_id: account_id,
          start_date: start_date,
          end_date: end_date,
          page: page
        }
        get('transactions', params)
      end

      # This endpoint retrieves a single transaction by entering
      # the transaction_id

      # Show single transaction
      # @param [String] id The Telleroo ID of the Transaction

      # {
      #   "transaction": {
      #     "id": "842963c5-e230-42ef-8de8-2b7a459026",
      #     "processed_at": "2016-12-01T12:15:23.486Z",
      #     "transaction_type": "Debit",
      #     "currency_code": "GBP",
      #     "amount": 100,
      #     "recipient_id": "442663c5-e230-32ef-8de8-1b7a459026",
      #     "status": "Preparing Payment",
      #     "status_info": "Creating payment request",
      #     "reconciliation": "f9q3408rh3",
      #     "reference": "Withdrawal Telleroo",
      #     "account_id": "ed5af7d2-741c-4905-a3ba-66d332d604",
      #     "tag": "Manutd",
      #     "end_balance": 2200,
      #     "idempotent_key": "6130348",
      #     "created_at": "2016-12-02T12:15:22.486Z",
      #     "updated_at": "2016-12-02T12:15:22.486Z"
      #   }
      # }

      # @return [Hash]
      def get_transaction(id)
        get("transactions/#{id}")
      end
    end
  end
end
