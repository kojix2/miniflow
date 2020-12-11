# frozen_string_literal: true

require 'tty-command'

module MiniFlow
  # MiniFlow  uses tty-command to execute the command.
  # Please see the following website for more information.
  # https://ttytoolkit.org/
  class TTYCommand < TTY::Command
    # TTY::Command custom printer
    # * change default colors.
    # https://github.com/piotrmurach/tty-command#34-custom-printer
    class CustomPretty < Printers::Pretty
      def print_command_start(cmd, *args)
        message = ["Running #{decorate(cmd.to_command, :cyan)}"]
        message << args.map(&:chomp).join(' ') unless args.empty?
        write(cmd, message.join)
      end

      def print_command_err_data(cmd, *args)
        message = args.map(&:chomp).join(' ')
        write(cmd, "\t#{decorate(message, :white)}", err_data)
      end

      def write(cmd, message, data = nil)
        cmd_set_uuid = cmd.options.fetch(:uuid, true)
        uuid_needed = cmd.options[:uuid].nil? ? @uuid : cmd_set_uuid
        out = []
        out << "[#{decorate(cmd.uuid, :green)}] " if uuid_needed && !cmd.uuid.nil?
        out << "#{message}\n"
        target = cmd.only_output_on_error && !data.nil? ? data : output
        target << out.join
      end
    end

    def initialize(*args)
      # Do not output uuid
      super(*args, printer: CustomPretty, uuid: true)
    end

    # run2 can execute the command in which the UNIX pipeline is used.
    def run2(*args)
      args.map!(&:to_s)
      command = args.join(' ')
      if include_meta_character?(command)
        run(command)
      else
        run(*args)
      end
    end

    def include_meta_character?(str)
      ['*', '?', '{', '}', '[', ']', '<', '>', '(', ')', '~', '&', '|', '\\',
       '$', ';', "'", '`', '"', "\n"].any? { |i| str.include?(i) }
    end
  end
end
