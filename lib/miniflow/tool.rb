# frozen_string_literal: true

require 'tty-box'
require 'tty-screen'

module MiniFlow
  # Burrow-Wheeler Aligner for short-read alignment.
  class Tool
    include FileCheck

    # Use the version options to check if the command is available
    def available?(command)
      # puts Pastel.new.magenta("Check #{self.class.name}")
      pastel = Pastel.new
      class_name = self.class.name.split('::').last
      begin
        result = cmd.run!(command)
      rescue Errno::ENOENT => e
        pastel = Pastel.new
        msg = "\n" \
              "Please make sure that the #{class_name} is available.\n\n"
        e.message << msg
        raise e
      end
      if result.failure?
        msg = "The exit status of #{command} is not zero.\n" \
              "Please make sure that the #{command} is available.\n\n"
        raise Errno::ENOENT, msg # FIXME
      else
        puts pastel.green.bold("✔ #{class_name}")
      end
    end

    # Get tool options
    def [](key)
      @options[key]
    end

    def cmd
      TTYCMD
    end

    # Calling the Ruby method executes a subcommand with the same name.
    # Since the Ruby methods are called first, care must be taken to avoid
    # name collisions. For example, subcommands such as `call` need to be
    # redefined.
    def method_missing(name, *args)
      cmd.run2(@command, name, *args)
    end

    # respond_to_missing?(sym, include_private)g
    # end
  end
end
