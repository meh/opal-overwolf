module Overwolf
	module Clipboard
		def self.get
			Promise.new.tap {|p|
				%x{
					overwolf.utils.getFromClipboard(function(value) {
						#{p.resolve `value || nil`};
					})
				}
			}
		end

		def self.set(value)
			`overwolf.utils.placeOnClipboard(#{value.to_s})`
		end
	end
end
