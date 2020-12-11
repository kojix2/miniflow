# frozen_string_literal: true

require 'tty-tree'
require 'tty-screen'

module Miniflow
  # Base class for all flows in Miniflow
  # The input file must be specified as an absolute path.
  # Each flow has one output directory
  class Flow
    include FileCheck

    # Define the initialize method according to the following rules
    # * Take file paths as arguments. The file paths can be either absolute or
    # relative.
    # * Other arguments are keyword arguments.
    def initialize
      raise NotImplementedError
    end

    def cmd
      TTYCMD
    end

    # This section is mainly for file validation.
    def before_run; end

    # This section is mainly used to validate the generated files, display
    # runtime information, etc.
    def after_run
      check_output_files
      show_results
    end

    # The main process. It must be implemented.
    def main_run
      raise NotImplementedError
    end

    # If you have a reason, you can overwrite it.
    # Normally, you should not change it.
    def run
      show_start
      before_run
      main_run
      after_run
    rescue TTY::Command::ExitError => e
      show_exit_error
      raise e
    rescue Errno::ENOENT => e # Maybe we should expand the scope of the error.
      show_exit_error
      raise e
    end

    # Show the banner when the workflow starts.
    def show_start
      @start_time = Time.now
      puts TTY::Box.frame(self.class.name,
                          "Start  : #{@start_time}",
                          width: TTY::Screen.width, padding: 1,
                          border: { left: false, right: false })
    end

    # Show the banner when the workflow is finished.
    def show_results(generated_files: true)
      @end_time = Time.now
      tree = if generated_files
               [' ',
                "Generated files: #{@out_dir}",
                ' ',
                TTY::Tree.new(@out_dir).render]
             else
               ''
             end
      puts
      puts TTY::Box.frame("Start  : #{@start_time}",
                          "End    : #{@end_time}",
                          "Time   : #{@end_time - @start_time} sec",
                          *tree,
                          title: { top_left: " #{self.class.name} " },
                          width: TTY::Screen.width, padding: 1)
    end

    # Show the banner when an error occurs and the workflow is abnormally interrupted.
    def show_exit_error
      @end_time = Time.now
      puts TTY::Box.error(
        "Flow   : #{self.class.name}\n" \
        "Start  : #{@start_time}\n" \
        "End    : #{@end_time}\n" \
        "Time   : #{@end_time - @start_time} sec",
        width: TTY::Screen.width, padding: 1
      )
    end

    # Returns the path in the output directory.
    # The file path is recorded. When the workflow is finished, the output
    # files are checked for existence in the `check_output_files` method.
    def odir(file_name)
      @output_files ||= []
      file_path = File.join(@out_dir, file_name)
      @output_files << file_path
      file_path
    end

    # Returns the path in the output directory.
    def dir(file_name)
      File.join(@out_dir, file_name)
    end

    # When the workflow is finished, make sure that all the registered output
    # files are present.Currently, the error does not occur even if the output
    # file does not exist. A warning will be shown.
    def check_output_files
      return if @output_files.nil?

      flag = true
      @output_files.uniq.each do |file_path|
        unless File.exist?(file_path)
          warn "Output file not found: #{file_path}"
          flag = false
        end
      end
      puts 'All output file exist.' if flag
    end
  end
end
