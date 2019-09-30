module States
  ALLOWED_SCALES = %w[K C F]
  class Base
    attr_reader :context

    def initialize(context = {})
      @context = context
    end
  end
end