# frozen_string_literal: true

require_relative '../fixtures/observable'

RSpec.describe Observable do
  before do
    Observers::Observables.reset
    Object.send(:remove_const, 'Observable')
    load 'spec/fixtures/observable.rb'
  end

  describe '#initialize' do
    it 'instantiates a class' do
      expect { Observable }.not_to raise_error
    end

    it 'creates an observable' do
      Observable
      expect(Observers::Observables.observables.count).to eq(1)
    end
  end
end
