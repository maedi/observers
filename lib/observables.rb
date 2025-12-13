# frozen_string_literal: true

require_relative 'models/observable'

module Observers
  class Observables
    class << self
      def reset
        @observables = {}
      end

      def observables
        @observables ||= {}
        @observables
      end

      def create(observable:)
        observables[observable] = Observable.new(observable:)
        observables[observable]
      end

      def observe(observable:, observer:)
        observable = observables[observable] || create(observable:)
        observable.add_observer(observer:)
      end
    end
  end
end
