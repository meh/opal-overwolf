require 'overwolf/window'
require 'overwolf/settings'
require 'overwolf/game'

module Overwolf
	def self.available?
		defined? `window.overwolf`
	end
end
