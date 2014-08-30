module Overwolf
	class Game
		def self.current
			Promise.new.tap {|p|
				%x{
					overwolf.games.getRunningGameInfo(function(result) {
						#{p.resolve Game.coerce(`result`)};
					});
				}
			}
		end

		def self.on(type, &block)
			case type
			when :change
				%x{
					overwolf.games.onGameInfoUpdated.addListener(function(game) {
						#{block.call(new(game))};
					});
				}

			when :launch
				%x{
					overwolf.games.onGameLaunched.addListener(function(game) {
						#{block.call(new(game))};
					});
				}
			end
		end

		def self.coerce(value)
			return if `value == null`

			if Array === value
				value.map { |v| new(v) }
			else
				new(v)
			end
		end

		include Native

		alias_native :id
		alias_native :title
		alias_native :width
		alias_native :height

		alias_native :focus?, :isInFocus
		alias_native :running?, :isRunning
		alias_native :capture?, :allowsVideoCapture

		alias_native :renderers
	end
end
