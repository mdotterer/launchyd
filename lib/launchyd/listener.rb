require 'listen'
require 'launchy'

module Launchyd
  class Listener
    extend Forwardable

    def_delegators :@listener, :start, :stop, :pause, :unpause

    def initialize(*directory_names)
      @listener = Listen.to(*directory_names) do |modified, added, removed|
        added.each { |f| self.added(f) }
      end
    end

    def added(path)
      Launchy.open(path)
    end
  end
end
