require 'test_helper'

module YARD
  class RedstormTest < Test::Unit::TestCase

    context 'configuration' do
      should 'fail if not given a config' do
        assert_equal(true, false)
      end
    end

  end
end
