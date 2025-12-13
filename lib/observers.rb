# frozen_string_literal: true

require_relative 'observation/deck'

module Observers
  def observable(observable = nil)
    observable = self if observable.nil?
    Deck.track(observable:)
  end

  def observe(observable)
    Deck.observe(observable:, observer: self)
  end
end
