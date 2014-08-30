module Overwolf
	module Settings
		def self.hotkey(name, &block)
			unless block
				return Promise.new.tap {|p|
					%x{
						overwolf.settings.getHotKey(name, function(result) {
							if (result.status == "success") {
								#{p.resolve(`result.hotkey`)};
							}
							else {
								#{p.reject(`result`)};
							}
						});
					}
				}
			end

			%x{
				var error;

				overwolf.settings.registerHotKey(name, function(result) {
					if (result.status == "error") {
						error = result.error;
					}
					else {
						#{block.call};
					}
				});

				if (error) {
					#{raise `error`};
				}
			}
		end
	end
end
