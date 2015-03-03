require 'overwolf/window'
require 'overwolf/settings'
require 'overwolf/game'
require 'overwolf/media'
require 'overwolf/clipboard'
require 'overwolf/keyboard'

module Overwolf
	def self.available?
		defined? `window.overwolf`
	end

	def self.launch(id)
		`overwolf.extensions.launch(id)`
	end

	def self.version
		`overwolf.version`
	end
end
