require 'overwolf/window'
require 'overwolf/settings'
require 'overwolf/game'
require 'overwolf/media'

module Overwolf
	def self.available?
		defined? `window.overwolf`
	end

	def self.launch(id)
		`overwolf.extensions.launch(id)`
	end
end
