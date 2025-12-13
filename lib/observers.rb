# frozen_string_literal: true

require_relative 'observables'
require_relative 'models/observer'

module Observers
  def observable(observable = nil)
    observable = self if observable.nil?
    Observables.create(observable:)
  end

  def observe(observable, order: 0)
    observer = Observer.new(observer: self, order:)
    Observables.observe(observable:, observer:)
  end
end
