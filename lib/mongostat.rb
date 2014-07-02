require "tempfile"
require "timeout"

require_relative "mongostat/version"
require_relative "mongostat/headers"

module Mongostat
  class ConnectionRefused < StandardError; end
  class NoData < StandardError; end

  class << self
    TEMP_FILE    ||= ::Tempfile.new("mongostat")
    DEFAULT_HOST   = "localhost:27017"

    def start(opts={})
      host = opts[:host] || DEFAULT_HOST
      cmd  = "mongostat --rowcount 0 -h #{host}"

      if u = opts[:username]
        cmd += " -u #{u}"
      end

      if p = opts[:password]
        cmd += " -p #{p}"
      end

      %x[#{cmd} > #{TEMP_FILE.path}]
    end

    def read
      Timeout::timeout(10) do
        loop do
          TEMP_FILE.seek(0, IO::SEEK_END)

          checks = proc do |line|
            line =~ /\w+/ &&
            !(line =~ /connected/) &&
            !(line =~ /insert/)
          end

          select([TEMP_FILE])
          line = TEMP_FILE.gets

          # TODO: this is getting very ugly
          if line
            if line.include?("refused")
              return {"err" => ConnectionRefused}
            end

            if line.include?("no data")
              return {"err" => NoData}
            end
          end

          if checks.call(line)
            return parse(line)
          end
        end
      end
    end

    def cleanup
      TEMP_FILE.close
      TEMP_FILE.unlink
    end

    def stop
      cleanup
    end

    private

    def parse(line)
      result = {}
      line.split.each_with_index do |value, index|
        key = HEADERS.keys[index]
        fn  = HEADERS[key]
        value = fn ? fn.call(value) : value

        result[key] = value
      end

      result
    end
  end
end
