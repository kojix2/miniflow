# frozen_string_literal: true

require_relative 'test_helper'

class TTYCommandTest < Minitest::Test
  def setup
    @tty_command = MiniFlow::TTYCommand.new
  end

  def test_include_meta_character?
    assert_equal false, @tty_command.include_meta_character?('a,b,c')
    assert_equal true, @tty_command.include_meta_character?('a,b | c')
    assert_equal true, @tty_command.include_meta_character?('a,b > c')
  end
end
