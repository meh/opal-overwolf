require 'promise'

module Overwolf
	class Window
		def self.current
			Promise.new.tap {|p|
				%x{
					overwolf.windows.getCurrentWindow(function(result) {
						if (result.status == "success") {
							#{p.resolve(new(`result.window`))};
						}
						else {
							#{p.reject(`result`)};
						}
					});
				}
			}
		end

		def self.open(name)
			Promise.new.tap {|p|
				%x{
					overwolf.windows.obtainDeclaredWindow(name, function(result) {
						if (result.status == "success") {
							#{p.resolve(new(`result.window`))};
						}
						else {
							#{p.reject(`result`)};
						}
					});
				}
			}
		end

		include Native

		alias_native :id

		alias_native :width
		alias_native :height

		alias_native :y
		alias_native :x

		alias_native :visible?, :isVisible

		def moving
			`overwolf.windows.dragMove(#@native.id)`

			self
		end

		def resizing(edge = :none)
			`overwolf.windows.dragResize(#@native.id, edge)`
		end

		def move(x, y)
			Promise.new.tap {|p|
				%x{
					overwolf.windows.changePosition(#@native.id, x, y, function() {
						#{p.resolve(self)};
					});
				}
			}
		end

		def resize(width, height)
			Promise.new.tap {|p|
				%x{
					overwolf.windows.changeSize(#@native.id, width, height, function() {
						#{p.resolve(self)};
					});
				}
			}
		end

		def minimize
			Promise.new.tap {|p|
				%x{
					overwolf.windows.minimize(#@native.id, function() {
						#{p.resolve(self)};
					});
				}
			}
		end

		def restore
			Promise.new.tap {|p|
				%x{
					overwolf.windows.restore(#@native.id, function() {
						#{p.resolve(self)};
					});
				}
			}
		end

		def close
			Promise.new.tap {|p|
				%x{
					overwolf.windows.close(#@native.id, function() {
						#{p.resolve(self)};
					});
				}
			}
		end
	end
end
