module Overwolf
	module Keyboard
		def self.send(stroke)
			`overwolf.utils.sendKeyStroke(#{stroke.to_s})`
		end
	end
end
