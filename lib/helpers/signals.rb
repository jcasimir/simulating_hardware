module Helpers
  module Signals
    LOW     = 0
    HIGH    = 1
    SIGNALS = [HIGH, LOW]

  private
    def value_of(source)
      source.respond_to?(:call) ? source.call : source
    end
  end
end