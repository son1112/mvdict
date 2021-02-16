# frozen_string_literal: true

class MvDict
  class Utils
    class Cli
      class Repl
        # TODO: handle defaults for inject differently
        def initialize(commander = MvDict::Commanders::Basic.new)
          @commander = commander
        end

        def expand(text, _choices)
          load_message('mvdict loaded ...')

          loop do
            print "\n> "
            print(
              evaluate(read)
            )
          end
        end

        private

        def evaluate(string)
          begin
            result = @commander.instance_eval(string)
          rescue StandardError => e
            print e
            return
          end

          if result.is_a?(Array)
            number_format(result)
          else
            print result.to_s
          end

          return
        end

        def number_format(array)
          array.each_with_index do |item, index|
            number = index+1
            print "#{number}) #{item}"
            unless number == array.size
              print "\n"
            end
          end
        end

        def read
          gets.strip
        end

        def load_message(message)
          print "\n"
          print "┏(-_-)┛┗(-_-﻿ )┓ #{message} ┗(-_-)┛┏(-_-)┓"
          print "\n"
        end
      end
    end
  end
end
