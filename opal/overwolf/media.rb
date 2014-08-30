module Overwolf
	module Media
		def self.screenshot
			Promise.new.tap {|p|
				%x{
					overwolf.media.takeScreenshot(function(result) {
						if (result.status == "success") {
							#{p.resolve `result.url`};
						}
						else {
							#{p.reject `result`};
						}
					});
				}
			}
		end

		def self.share(image, description = "")
			Promise.new.tap {|p|
				%x{
					overwolf.media.shareImage(image, description, function(result) {
						if (result.status == "success") {
							#{p.resolve};
						}
						else {
							#{p.reject};
						}
					});
				}
			}
		end
	end
end
