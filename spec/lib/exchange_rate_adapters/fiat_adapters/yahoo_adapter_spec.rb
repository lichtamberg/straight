require 'spec_helper'

RSpec.describe Straight::ExchangeRate::YahooAdapter do

  before :all do
    VCR.insert_cassette 'exchange_rate_adapters/fiat_adapters/yahoo_adapter'
  end

  after :all do
    VCR.eject_cassette
  end

  before(:each) do
    @exchange_adapter = Straight::ExchangeRate::YahooAdapter.instance
  end

  it "finds the rate for currency code" do
    expect(@exchange_adapter.rate_for('RUB')).to be_kind_of(Numeric)
    expect( -> { @exchange_adapter.rate_for('KZT') }).to raise_error(Straight::ExchangeRate::Adapter::CurrencyNotSupported)
  end

end
