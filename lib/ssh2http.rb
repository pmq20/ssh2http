require 'open-uri'
require "ssh2http/version"

class Ssh2http
  def initialize(destination, *cmds)
    @destination = destination
    @cmds = cmds
  end

  def run!
    case cmd
    when 'git-upload-pack'
      upload!
    when 'git-receive-pack'
      receive!
    else
      die 'Unknown command'
    end
  end

  def upload!
    open(url('/info/refs?service=git-upload-pack')) do |f|
      f.gets # skip the first line
      f.read(4) # skip 0000
      f.each_line {|line| puts line}
    end
    exit 0
  end

  def receive!
    raise NotImplementedError
  end

  def cmd
    @cmds[0]
  end

  def key
    @cmds[1].gsub(/['"]/, '')
  end

  def url(part)
    "#{@destination}#{key}#{part}"
  end

  def debug
    var('@cmds')
    var('@destination')
    var('RUBY_VERSION')
    var('::Ssh2http::VERSION')
    ENV.each do |k,v|
      var("ENV[#{k.inspect}]")
    end
  end

  def var(var)
    STDERR.puts "#{var}=#{eval(var).inspect}"
  end

  def die(msg)
    self.class.die("#{@destination} #{@cmds} #{msg}")
  end

  def self.die(msg)
    STDERR.puts msg
    exit 1
  end
end
