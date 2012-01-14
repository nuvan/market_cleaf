## MarketCleaf ##
Market Cleaf is a Ruby library that leverages MarketBeat to create watches and alarms for the available MarketBeat indicators

### Installation ###
    # Installing as Ruby gem
    $ gem install market_cleaf

    # Cloning the repository
    $ git clone git://github.com/nuvan/market_cleaf.git

## Code Example ###

	require 'rubygems'
	gem 'market_beat', '= 0.1.2'
	gem 'market_cleaf', '= 0.0.1'
	require 'market_beat'
	require 'market_cleaf'


	# Configure MarketBeat module with proxy if one need's to
	#MarketBeat.set_proxy_address "localhost"
	#MarketBeat.set_proxy_port 3128

	#Arguments => beat_name, symbol, market_beat_indicator
	MarketCleaf.add_beat :EUR_USD, :EUR_USD, :currency_rate
	MarketCleaf.add_beat :USD_EUR, :USD_EUR, :currency_rate

	MarketCleaf.add_beat :SELL_USD, :USD_EUR, :currency_rate


	#bought USD @ 1,272411 EUR
	#Waiting to sell formula
	#print = ->(value){puts value}

	args = Hash[ [ [:sym, :EUR_USD], [:loss, 0.25], [:bought, 1.272411] ] ]

	#args[:beat] will hold the ouput value/string from MarketBeat sym function
	sell = ->(args) { if value = args[:beat].call()
                    value = args[:beat].call().split(",")[1].to_f
                    if (value < (args[:bought].to_f-args[:bought].to_f*(args[:loss].to_f/100.0)))
                      puts "SELL #{args[:sym]} NOW @ #{ (args[:bought].to_f-args[:bought].to_f*(args[:loss].to_f / 100.0)) }!"
                    else
                      puts "CURRENT -> #{value} :: BOUGHT LESS 0.25% -> #{(args[:bought].to_f-args[:bought].to_f*(args[:loss].to_f/100.0))}"
                    end
                  else
                    puts "No data available."
                  end
                }
                   
				MarketCleaf.monitor_beat :EUR_USD, 5, sell, args

				#MarketCleaf.monitor_beat :EUR_USD, 10, sell, args
