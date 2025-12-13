# frozen_string_literal: true

module Observers
  class Observation
    attr_reader :observers

    def initialize(observable:)
      @observable = observable
      @observers = []
    end

    def add_observer(observer:)
      @observers << observer
      @observers.sort_by(&:order)
    end
  end
end
