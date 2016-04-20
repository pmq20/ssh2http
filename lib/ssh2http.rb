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
      f.each_line do |line|
        if "001e# service=git-upload-pack\n" == line
          f.read(4) # skip "0000"
          next
        end
        print line
      end
    end
    STDOUT.flush

    input = ''
    while line = STDIN.gets
      input += line
      break if line =~ /0009done\n$/
    end

    url = URI.parse(url('/git-upload-pack'))
    Net::HTTP.start(url.host, url.port) do |http|
      request = Net::HTTP::Post.new url.path
      request.body = input
      request['Content-Type'] = 'application/x-git-upload-pack-request'
      http.request request do |response|
        response.read_body do |chunk|
          STDOUT.write chunk
          STDOUT.flush
        end
      end
    end
  end

  def receive!
    open(url('/info/refs?service=git-receive-pack')) do |f|
      f.each_line do |line|
        if "001f# service=git-receive-pack\n" == line
          f.read(4) # skip "0000"
          next
        end
        print line
      end
    end
    STDOUT.flush

    input = STDIN.read
    url = URI.parse(url('/git-receive-pack'))
    http = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Post.new(url.path)
    request.body = input
    request['Content-Type'] = 'application/x-git-receive-pack-request'
    response = http.request(request)
    print response.body
    STDOUT.flush
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
