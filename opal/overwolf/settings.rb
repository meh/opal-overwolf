module Overwolf
	module Settings
		def self.hotkey(name, &block)
			error = nil

			%x{
				overwolf.settings.registerHotKey(name, function(result) {
					if (result.status == "error") {
						error = result.error;
					}
					else {
						#{block.call};
					}
				});
			}

			raise error if error
		end
	end
end
