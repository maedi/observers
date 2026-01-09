# frozen_string_literal: true

require_relative '../../lib/observers'
require_relative '../fixtures/low_event'
require_relative '../fixtures/class_publisher'
require_relative '../fixtures/class_subscribers'

RSpec.describe 'Class Subscribers' do
  before do
    Observers::Observables.reset

    Object.send(:remove_const, 'ClassPublisher')
    Object.send(:remove_const, 'NilSubscriber')
    Object.send(:remove_const, 'TrueSubscriber')
    Object.send(:remove_const, 'ActionSubscriber')

    load 'spec/fixtures/class_publisher.rb'
    load 'spec/fixtures/class_subscribers.rb'
  end

  describe 'Observables#observables' do
    it 'creates an observer' do
      expect(Observers::Observables.observables[ClassPublisher].observers.count).to eq(3)
    end
  end

  describe 'Observers#trigger' do
    context 'with action' do
      let(:actionable) { :action }

      before do
        allow(TrueSubscriber).to receive(:action)
      end

      it "triggers an observer's action" do
        ClassPublisher.trigger actionable
        expect(TrueSubscriber).to have_received(:action)
      end

      it "triggers an observer's action via method" do
        ClassPublisher.trigger_via_method(actionable)
        expect(TrueSubscriber).to have_received(:action)
      end
    end

    context 'with event' do
      let(:actionable) { LowEvent.new(action: :action) }

      before do
        allow(TrueSubscriber).to receive(:action).with(event: actionable)
      end

      it "triggers an observer's action" do
        ClassPublisher.trigger actionable
        expect(TrueSubscriber).to have_received(:action)
      end

      it "triggers an observer's action via method" do
        ClassPublisher.trigger_via_method(actionable)
        expect(TrueSubscriber).to have_received(:action)
      end
    end

    context 'when the subscriber overrides the action' do
      let(:actionable) { :action }

      before do
        allow(ActionSubscriber).to receive(:overridden_action)
      end

      it "triggers an observer's overridden action" do
        ClassPublisher.trigger actionable
        expect(ActionSubscriber).to have_received(:overridden_action)
      end

      it "triggers an observer's overridden action via method" do
        ClassPublisher.trigger_via_method(actionable)
        expect(ActionSubscriber).to have_received(:overridden_action)
      end
    end
  end
end
