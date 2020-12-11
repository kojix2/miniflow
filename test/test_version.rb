# frozen_string_literal: true

require_relative 'test_helper'

class MiniFlowTest < Minitest::Test
  def test_that_it_has_a_version_number
    assert_kind_of String, ::MiniFlow::VERSION
  end
end
