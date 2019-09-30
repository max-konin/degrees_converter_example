require_relative './states/input_source_scale.rb'

class Application
  def run
    @state = States::InputSourceScale.new
    while true
      @state.render
      @state = @state.next()
    end
  end
end