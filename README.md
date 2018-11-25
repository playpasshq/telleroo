# Telleroo

This is a simple wrapper for the Telleroo API. API Documentation is [available here](http://docs.telleroo.com). This gem uses `MultiJson` to parse responses which are otherwise returned unadulterated.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'telleroo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install telleroo

## Configuration

`Telleroo::Client` can be configured from an initializer:

```

  Telleroo.configure do |config|
    config.authorization_token = "YOUR_AUTH_TOKEN"
    config.endpoint = 'https://sandbox.telleroo.com'
  end

```

or by passing an options block to `Telleroo::Client.new`

```

client = Telleroo::Client.new do |config|
  config.authorization_token = "YOUR_AUTH_TOKEN"
  config.endpoint = 'https://sandbox.telleroo.com'
end

```

The `http_adapter` option can be used to set the underlying HTTP adapter for Faraday:

```
config.http_adapter = :typhoeus
```

Use an array to pass further options to the HTTP adapter itself:

```
config.http_adapter = [:typhoeus, timeout_ms: 100]
```

## Usage

After configuring a `client`, the following calls are available to you:

**List Accounts**

Retrieves all bank accounts assigned to your company
```
client.accounts()

```

**List Recipients**

Retrieves all recipients under your company.
```
client.recipients()

```

**Get Recipient**

Retrieves a single recipient given a recipient_id.

```
client.get_recipient("ff17b231-2bc4-485e-967e-231867e15fd6")

```

**Create Recipient**

Creates a single recipient.

Note: `GBP` Recipients require `account_no` and `sort_code` passed in `options` while `EUR` require `iban` and `bic`.

```
client.create_recipient(name: 'Nick Lloyd',
                        currency_code: 'GBP',
                        options: {
                          account_no: '72345678',
                          sort_code: '623456'
                        }
                      )
```

**Delete Recipient**

Retrieves a single recipient given a recipient_id.

```
client.delete_recipient("ff17b231-2bc4-485e-967e-231867e15fd6")

```

**Create Bank Transfer to Recipient**

Triggers an instantaneous bank transfer to a existing recipient from your account. [See docs](http://docs.telleroo.com/#bank-transfers-to-recipient-id) for additional available params to pass into options.

```
client.create_transfer(
        account_id: 'a6a2b79c-33b5-4ed5-90fd-bfb8f1d4085a',
        currency_code: 'GBP',
        amount: 10000,
        recipient_id: 'ff17b231-2bc4-485e-967e-231867e15fd6',
        idempotent_key: 'abcd-123456789-efgh',
        options: {
          reference: 'foobar'
        }
      )
```

**Create an Adhoc Bank Transfer**

Send all params required to both create a Recipient and transfer funds in a single call.

```
client.create_adhoc_transfer({
        account_id: 'a6a2b77c-33b5-4ed5-90fd-bfb8f1d4085a',
        currency_code: 'GBP',
        amount: 10000,
        recipient_name: 'Rick Floyd',
        account_no: 12345678,
        sort_code: 665544,
        idempotent_key: 'abcd-123456789-efgh',
        reference: 'foo',
        tag: 'bar',
        reconciliation: 'baz'
      })

```

**List Transactions**

Returns all activity on a specified bank account. [See docs](http://docs.telleroo.com/#transactions-list) for additional available params to pass into options.

```
client.transactions(
        account_id: 'a6a2b77c-33b5-4ed5-90fd-bfb8f1d4085a',
        start_date: '09-06-2017',
        end_date: '09-07-2017'
      )

```

**Get Transaction**

Retrieves all relevant data of a single transaction including the transfer status.

```
get_transaction(id)

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/playpasshq/telleroo.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

