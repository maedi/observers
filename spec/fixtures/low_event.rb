# frozen_string_literal: true

class LowEvent
  attr_reader :action

  def initialize(action: :handle_event)
    @action = action
  end
end
