require 'telleroo/api/accounts'
require 'telleroo/api/recipients'
require 'telleroo/api/bank_transfers'
require 'telleroo/api/transactions'

module Telleroo
  # Includes all API Modules
  module API
    include Telleroo::API::Accounts
    include Telleroo::API::Recipients
    include Telleroo::API::BankTransfers
    include Telleroo::API::Transactions
  end
end
