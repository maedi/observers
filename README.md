<a href="https://rubygems.org/gems/observers" title="Install gem"><img src="https://badge.fury.io/rb/observers.svg" alt="Gem version" height="18"></a>

# Observers

Observe any objects of any kind and trigger actions/events on those objects.

Observers are decoupled from the classes/objects they observe. Instead of directly observing a particular object, we observe the "key" that represents that object. Any class or object can be observed out of the box, you just need to `observe` it:
```ruby
class MySubscriber
  include Observers
  observe MyPublisher

  def self.action
    # Method that will be called upon trigger.
  end
end
```

ℹ️ **Note:** You can observe any entity; classes, objects, structs, strings or symbols are all suitable.

## Triggers

`include Observers` in the class that you'd like to trigger actions/events from:

```ruby
class MyPublisher
  include Observers
  # "trigger" method now available on class and instance.
end
```

### Actions

Calls the `my_action` method on MySubscriber and returns the last observer's return value that was non-nil:
```ruby
MyPublisher.trigger action: :my_action
```

Trigger the action on any observers to `any_object_or_class`:
```ruby
MyPublisher.trigger any_object_or_class, action: :my_action
```

### Events

Observers integrates with [LowEvent](https://github.com/low-rb/low_event), allowing you to pass an event to your observer.

Calls the `handle(event:)` method on all observers to `MySubscriber` and return the last observer's return value that was non-nil:
```ruby
MyPublisher.trigger event: LowEvent.new(event_data)
```

Trigger the event on any observers to `any_object_or_class`:
```ruby
MyPublisher.trigger any_object_or_class, event: LowEvent.new(event_data)
```

ℹ️ **Note:** Events should inherit from `LowEvent` or provide an `action` method.

### Default Action

The default action that will be called on an observer is `handle` or `handle(event:)` if the action or event don't specify this.

### Overridden Action

You can also override the action handler on the `Observer` side, to always be a certain action regardless of the trigger's action/event's action.

```ruby
class MySubscriber
  include Observers
  observe MyPublisher, overridden_action: :clear_cache

  def self.clear_cache
    # All triggers will call this method instead.
  end
end
```

## Installation

Add `gem 'observers'` to your Gemfile then:
```
bundle install
```
