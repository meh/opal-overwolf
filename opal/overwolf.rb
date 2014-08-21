require 'overwolf/window'
require 'overwolf/settings'

module Overwolf
	def self.available?
		defined? `window.overwolf`
	end
end
