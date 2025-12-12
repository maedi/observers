# frozen_string_literal: true

require_relative '../models/observation'
require_relative '../models/observer'

module Observers
  class ObservationDeck
    def initialize
      @observations = {}
    end

    def track(observable:)
      @observations[observable] = Observation.new(observable:)
    end

    def observe(observable:, observer:)
      observation = @observations[observable]
      observation.add_observer(observer:)
    end
  end
end
