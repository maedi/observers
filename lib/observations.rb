# frozen_string_literal: true

require_relative 'models/observation'

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
        observations[observable] = Observation.new(observable:)
        observations[observable]
      end

      def observe(observable:, observer:)
        observation = observations[observable] || create(observable:)
        observation.add_observer(observer:)
      end
    end
  end
end
