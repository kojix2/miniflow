# frozen_string_literal: true

require_relative 'miniflow/version'
require_relative 'miniflow/tty_command'
require_relative 'miniflow/filecheck'
require_relative 'miniflow/flow'
require_relative 'miniflow/tool'

module Miniflow
  TTYCMD = TTYCommand.new
end
