# frozen_string_literal: true

require_relative 'models/observable'

module Observers
  class Observables
    class MissingObservableError < StandardError; end

    class << self
      def observables
        @observables ||= {}
        @observables
      end
      alias all observables

      def upsert(key:)
        observables[key] = Observable.new(key:) if observables[key].nil?
        observables[key]
      end

      def reset
        @observables = {}
      end

      def observe(key:, observer:)
        observable = observables[key] || upsert(key:)
        observable.add_observer(observer:)
      end

      # @return: The last result of the trigger.
      def trigger(actionable:, key:)
        action, event = parse_actionable(actionable:)

        observable = observables[key]
        raise MissingObservableError, "Observable key '#{key}' not found" if observable.nil?

        last_result = nil

        observables[key].observers.each do |observer|
          result = observer.trigger(action:, event:)
          last_result = result unless result.nil?
        end

        last_result
      end

      private

      def parse_actionable(actionable:)
        action = actionable
        event = nil

        if actionable.class.ancestors.any? { |ancestor| ancestor.to_s == 'Low::Event' }
          event = actionable
          action = event.action
        end

        [action, event]
      end
    end
  end
end
