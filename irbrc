### -*- ruby-mode -*-

require 'irb/completion'
require 'pp'

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:PROMPT_MODE] = :SIMPLE unless ENV["TERM"] == "dumb"

# Profile the provided block
def profile
  require 'profiler'
  Profiler__.start_profile
  yield
  Profiler__.stop_profile
  Profiler__.print_profile($stdout)
end
