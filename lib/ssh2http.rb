require "ssh2http/version"

module Ssh2http
  def self.exec(origin_cmd)
    unless origin_cmd
      puts "Welcome to ssh2http!"
      return true
    end
    # Your code goes here...
    true
  end
end
