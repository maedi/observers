# frozen_string_literal: true

module Observers
  class Observation
    def initialize(observable:)
      @observable = observable
      @observers = []
    end

    def add_observer(observer:)
      @observers << observer
      @observers.sort_by(&:priority)
    end
  end
end
