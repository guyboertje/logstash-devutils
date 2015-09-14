require 'concurrent-ruby'

module Timing
  def self.measure(&block)
    start = Concurrent.monotonic_time #on jruby calls System.nanoTime
    block.call
    stop = Concurrent.monotonic_time
    stop - start
  end
end

RSpec::Matchers.define :take_less_than do |n|
  chain :microseconds do; end

  match do |block|
    (Timing.measure(&block)) / 1_000.0
  end
end
