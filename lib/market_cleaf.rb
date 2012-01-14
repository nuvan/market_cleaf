# Copyright (c) 2011 Nuno Valente
#
# Market Cleaf is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
#require File.dirname(__FILE__) + '/market_cleaf/yahoo'
require 'monitor'

module MarketCleaf

  @@beats           = Hash.new
  @@beat_contitions = Hash.new

  # Add a market beat
  def self.add_beat(name, market_symbol, market_beat_method)
    #store the lambda inside the @@beats Hash to call it later
    @@beats[name] = {:l => ->(method, symbol) { MarketBeat.send(method, symbol) },
                     :args => {:sym => market_symbol, :meth => market_beat_method} }
  end
  
  def self.call_beat(name)
    hash = @@beats[name]
    hash[:l].call(hash[:args][:meth], hash[:args][:sym])
  end
  
  # Output a MarketBeat sample to stdout in 'interval' 
  def self.monitor_beat(name, interval, *landa)
    #always call beat
    beat = ->{self.call_beat name}
    #base args
    args = Hash[ [[:name, name], [:beat, beat]] ]
    #default lambda method
    print   = ->(params){puts "#{params[:name]} -> #{params[:beat].call}"}
    #override default lambda if given and merge args if given
    lambda = landa[0] || print
    args.merge!(landa[1]) if landa[1]
    #lambda  = landa[0] || print
    #args    = landa[1] if landa[1]
    tb = Thread.new { (sleep interval; (lambda.call(args))) while true}
    tb.join
  end
  
  def self.monitor_beat_condition(name, interval, condition, args)
    tb = Thread.new { (sleep interval; condition.call(self.call_beat name, args)) while true}
    tb.join
  end
  
end