# frozen_string_literal: true

require_relative '../observatory'

module Observers
  def observable(observable = nil)
    observable = self if observable.nil?
    Observatory.track(observable:)
  end

  def observe(observable)
    Observatory.observe(observable:, observer: self)
  end
end
