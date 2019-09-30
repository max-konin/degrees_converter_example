require_relative './../io_adapter.rb'
require_relative './base.rb'
require_relative './input_value'

module States
  class InputTargetScale < Base
    def render
      IOAdapter.instance.write('Input the target scale (C, F, K)')
    end

    def next
      value = IOAdapter.instance.read
      if States::ALLOWED_SCALES.include?(value)
        avoid_similar_scales(value)
      else
        IOAdapter.instance.write('The target scale must be "C", "F", or "K"')
        self
      end
    end

    private

    def avoid_similar_scales(value)
      if value == context[:source_scale]
        IOAdapter.instance.write('The target scale must not equal the source scale')
        self
      else
        InputValue.new(context.merge(target_scale: value))
      end
    end  
  end
end
