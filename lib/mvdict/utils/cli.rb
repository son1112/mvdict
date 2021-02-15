# frozen_string_literal: true

require_relative './cli/repl.rb'
require 'tty-prompt'

class MvDict
  class Utils
    class Cli

      CHOICES = [
        {
          key: 's',
          name: 'fofo',
          value: :yes
        }, {
          key: 'n',
          name: 'lajfd',
          value: :no
        }, {
          key: 'q',
          name: 'lskdjf',
          value: :quit
        }
      ]

      def initialize(type: :simple)
        @type = type
        @prompt ||= prompt
      end

      def run
        @prompt.expand('>', CHOICES)
      end

      private

      def prompt
        @type == :simple ? repl : tty_prompt
      end

      def repl
        MvDict::Utils::Cli::Repl.new
      end

      def tty_prompt
        TTY::Prompt.new
      end
    end
  end
end

# require 'tty-box'
# require 'tty-command'

# cmd = TTY::Command.new
# cmd.run('ls -la')
# cmd.run('echo Hello!')

# box = TTY::Box.frame(
#                        "Drawing a box in",
#                        "terminal emulator",
#                        padding: 3,
#                        align: :center
#                     )

# print box

