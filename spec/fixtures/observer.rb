require_relative '../../lib/observers'
require_relative 'observable'

class Observer
  extend Observers

  observe Observable
end
