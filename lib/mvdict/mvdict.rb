# frozen_string_literal: true

require_relative './utils.rb'
require_relative './errors.rb'
require_relative './commanders.rb'

class MvDict
  def self.run
    MvDict::Utils::Cli.new.run
  end
end
