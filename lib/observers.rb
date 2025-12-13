# frozen_string_literal: true

require_relative 'observations'

module Observers
  def observable(observable = nil)
    observable = self if observable.nil?
    Observations.create(observable:)
  end

  def observe(observable)
    Observations.observe(observable:, observer: self)
  end
end
