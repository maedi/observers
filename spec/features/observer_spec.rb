# frozen_string_literal: true

require_relative '../fixtures/observer'

RSpec.describe Observer do
  before do
    Observers::Observables.reset
    Object.send(:remove_const, 'Observer')
    load 'spec/fixtures/observer.rb'
  end

  describe '#initialize' do
    it 'instantiates a class' do
      expect { Observer }.not_to raise_error
    end

    it 'creates an observer' do
      Observer
      expect(Observers::Observables.observables.values.first.observers.count).to eq(1)
    end
  end
end
