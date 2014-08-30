module Overwolf
	class Game
		def self.coerce(value)
			return if `value == null`

			if Array === value
				value.map { |v| new(v) }
			else
				new(v)
			end
		end

		def self.current
			Promise.new.tap {|p|
				%x{
					overwolf.games.getRunningGameInfo(function(result) {
						#{p.resolve coerce(`result`)};
					});
				}
			}
		end

		def self.on(type, &block)
			case type
			when :change
				%x{
					overwolf.games.onGameInfoUpdated.addListener(function(update) {
						#{block.call(Update.new(`update`))};
					});
				}

			when :launch
				%x{
					overwolf.games.onGameLaunched.addListener(function(game) {
						#{block.call(coerce(`game`))};
					});
				}
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

		class Update
			include Native

			alias_native :focus?, :focusChanged
			alias_native :game?, :gameChanged
			alias_native :resolution?, :resolutionChanged
			alias_native :running?, :runningChanged

			def game
				Game.new(`#@native.gameInfo`)
			end
		end
	end
end
