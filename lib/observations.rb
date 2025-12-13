# frozen_string_literal: true

require_relative 'models/observation'
require_relative 'models/observer'

module Observers
  class Observations
    class << self
      def reset
        @observations = {}
      end

      def observations
        @observations ||= {}
        @observations
      end

      def create(observable:)
        @observations ||= {}
        @observations[observable] = Observation.new(observable:)
      end

      def observe(observable:, observer:)
        observation = observations[observable]
        observation.add_observer(observer:)
      end
    end
  end
end
