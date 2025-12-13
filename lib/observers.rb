# frozen_string_literal: true

require_relative 'observations'
require_relative 'models/observer'

module Observers
  def observable(observable = nil)
    observable = self if observable.nil?
    Observations.create(observable:)
  end

  def observe(observable, order: 0)
    observer = Observer.new(observer: self, order:)
    Observations.observe(observable:, observer:)
  end
end
