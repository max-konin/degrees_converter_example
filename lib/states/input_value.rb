require_relative './../io_adapter.rb'
require_relative './base.rb'
require_relative './calculation.rb'

module States
  class InputValue < Base
    def render
      IOAdapter.instance.write('Input a value')
    end

    def next
      value = IOAdapter.instance.read
      if /^(\-|[0-9])[0-9]*$/.match?(value)
        Calculation.new(context.merge(value: value.to_i))
      else
        IOAdapter.instance.write('The value must be a number')
        self
      end
    end
  end
end
