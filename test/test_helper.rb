test = File.expand_path('../../test', __FILE__)
$LOAD_PATH.unshift(test) unless $LOAD_PATH.include?(test)

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rubygems'
require 'bundler/setup'
require 'test-unit'
require 'shoulda/context'

