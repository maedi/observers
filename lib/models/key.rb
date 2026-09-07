# frozen_string_literal: true

module Observers
  class NoObserversError < StandardError; end

  class Key
    attr_reader :observers

    def initialize(key:)
      @key = key
      @observers = []
    end

    def observe(object:, action:)
      # TODO: We can observe objects directly, no need to wrap in an observer, unless need to let the object's observer override the action?
      # A future reason I can think of for keeping observer wrapper is to track whether the object has implemented certain actions/methods.
      @observers << Observer.new(object:, action:)
    end

    # @returns: The result of the last observer with a non-nil value.
    def trigger(action: nil, event: nil)
      raise NoObserversError, "No observers configured for #{@key}" if @observers.empty?

      action = event.action if event && action.nil?
      action = [:handle] if action.empty?

      last_result = nil

      @observers.each do |observer|
        action.each do |a|
          result = observer.trigger(action: a, event:)
          last_result = result unless result.nil?
          yield if block_given?
        end
      end

      last_result
    end

    # @returns: The result of the first observer and the first action with a non-nil value.
    def take(action: nil, event: nil)
      raise NoObserversError, "No observers configured for #{@key}" if @observers.empty?

      action = event.action if event && action.nil?
      action = [:handle] if action.empty?

      @observers.each do |observer|
        action.each do |a|
          result = observer.trigger(action: a, event:)
          yield if block_given?
          return result unless result.nil?
        end
      end

      # None of the observers returned a non-nil value.
      nil
    end
  end
end
