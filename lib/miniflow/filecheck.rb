# frozen_string_literal: true

require 'fileutils'

module Miniflow
  module FileCheck
    module_function

    # Checks that the file exists and that the extension is correct.
    # @params path [String] The path to the file to check if it exists
    # @params extnames [Array, String] File extensions to check.
    # Multiple extensions can be specified in an array.
    def check_file(path, extnames)
      check_file_extname(path, extnames)
      check_file_exist(path)
    end

    # Checks if the file exists in the specified path.
    # @params path [String] The path to the file to check if it exists.
    def check_file_exist(path)
      raise "Cannot find: #{path}" unless File.exist?(path)
    end

    # Make sure that the file has the specified extension.
    # @params path [String] The path to the file.
    # @params extnames [Array, String] File extensions to check.
    def check_file_extname(path, extnames)
      case extnames
      when Array
        raise "Extension is not #{extnames}: #{path}" unless extnames.include?(File.extname(path))
      when File.extname(path)
        true
      else
        raise "Extension is not #{extnames}: #{path}"
      end
    end

    # Creates a directory and all its parent directories.
    def mkdir_p(*arg)
      FileUtils.mkdir_p(*arg)
    end
  end
end
