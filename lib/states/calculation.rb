require_relative './../io_adapter.rb'
require_relative './../temperature.rb'
require_relative './base.rb'
require_relative './input_source_scale'

module States
  class Calculation < Base
    def render
      result = Temperature.new(context[:value])
                          .from(context[:source_scale])
                          .to(context[:target_scale])
                          .value
      IOAdapter.instance.write("Result: #{result}")
    end

    def next
      InputSourceScale.new
    end
  end
end
