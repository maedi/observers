# frozen_string_literal: true

require_relative 'observables'
require_relative 'models/observer'

module Observers
  def self.included(klass)
    klass.extend Observers
  end

  def observables
    Observables.observables
  end

  def observable(key = self)
    Observables.upsert(key:)
  end

  # TODO: Unit test order.
  def observe(key, action = nil, order: Observables.observables.count)
    observer = Observer.new(observer: self, action:, order:)
    Observables.observe(key:, observer:)
  end

  # Returns the last observer with a non-nil return value.
  def trigger(actionable, key = nil)
    Observables.trigger(actionable:, key: key || self)
  end

  # TODO: Provide a "pipe/port/take" method that uses ractors to be concurrent... if supplied with immutable Data?
end
