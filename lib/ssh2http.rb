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
    raise NotImplementedError
  end

  def receive!
    raise NotImplementedError
  end

  def cmd
    @cmds[0]
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
