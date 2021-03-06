module Ruy
  module Conditions

    # Expects that a context attribute will be greater than the given value.
    class GreaterThan < Condition
      attr_reader :attr, :value

      # @param value
      # @param attr Context attribute's name
      # @yield a block in the context of the current rule
      def initialize(value, attr, &block)
        super
        @value = value
        @attr = attr
      end

      def call(var_ctx)
        @value < var_ctx.resolve(@attr)
      end

      def ==(o)
        o.kind_of?(GreaterThan) &&
          attr == o.attr &&
          value == o.value
      end
    end
  end
end
