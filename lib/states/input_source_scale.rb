require_relative './../io_adapter.rb'
require_relative './base.rb'
require_relative './input_target_scale'

module States
  class InputSourceScale < Base
    def render
      IOAdapter.instance.write('Input the source scale (C, F, K)')
    end

    def next
      value = IOAdapter.instance.read
      if States::ALLOWED_SCALES.include?(value)
        InputTargetScale.new(source_scale: value)
      else
        IOAdapter.instance.write('The source scale must be "C", "F", or "K"')
        self
      end
    end
  end
end
