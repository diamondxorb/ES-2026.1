class Numeric
  @@currencies = {"dollar" => 1.0, "yen" => 0.013, "euro" => 1.292, "rupee" => 0.019}
  
  def method_missing(method_id)
    singular_currency = method_id.to_s.gsub(/s$/, "")
    
    if @@currencies.has_key?(singular_currency)
      Currency.new(self * @@currencies[singular_currency], singular_currency)
    else
      super
    end
  end

  def in(target_currency)
    singular_target = target_currency.to_s.gsub(/s$/, "")

    if @@currencies.has_key?(singular_target)
      if self.is_a?(Currency)
        self.value / @@currencies[singular_target]
      else
        self / @@currencies[singular_target]
      end
    else
      super
    end
  end
end

class Currency
  attr_reader :value, :currency

  def initialize(value, currency)
    @value = value
    @currency = currency
  end

  def in(target_currency)
    singular_target = target_currency.to_s.gsub(/s$/, "")
    rates = Numeric.class_variable_get(:@@currencies)
    value_dollar = @value * rates[@currency]
    value_dollar / rates[singular_target]

  end
end

if __FILE__ == $PROGRAM_NAME
  puts 5.dollars.in(:euros)
  puts 10.euros.in(:rupees)
  puts 1.rupee.in(:yen)
  puts 100.yen.in(:dollars)

  puts 5.dollar.in(:euro)
  puts 10.euros.in(:rupee)

  puts 5.dollars.in(:euros).in(:rupees)
end