# frozen_string_literal: true

require_relative '../fixtures/publisher'

RSpec.describe Publisher do
  subject(:publisher) { described_class.new }

  describe '#initialize' do
    it 'instantiates a class' do
      expect { publisher }.not_to raise_error
    end
  end
end
