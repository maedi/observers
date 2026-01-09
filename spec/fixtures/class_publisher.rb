# frozen_string_literal: true

require_relative '../../lib/observers'

class ClassPublisher
  extend Observers
  observable

  class << self
    def trigger_via_method(actionable)
      trigger actionable
    end
  end
end
