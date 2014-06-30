require "mongostat/version"

module Mongostat
  class << self
    TEMP_FILE    ||= Tempfile.new("mongostat")
    HEADERS        = %w(
      dbname insert query update delete getmore command flushes mapped
      vsize res faults locked idxmiss qr|qw ar|aw netIn netOut conn time
    )
    DEFAULT_HOST   = "localhost:27017"

    def start(opts={})
      host = opts[:host] || DEFAULT_HOST
      cmd  = "mongostat --rowcount 0 --discover -h #{host}"

      if opts[:username]
        cmd += " -u %s"
      end

      if opts[:password]
        cmd += " -p %s"
      end

      %x[#{cmd} > #{TEMP_FILE.path}]
    end

    def read
      loop do
        TEMP_FILE.seek(0, IO::SEEK_END)

        checks = proc do |line|
          line =~ /\w+/ &&
          !(line =~ /connected/) &&
          !(line =~ /insert/)
        end

        select([TEMP_FILE])
        line = TEMP_FILE.gets

        if checks.call(line)
          return parse(line)
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
        result[HEADERS[index]] = value
      end

      result
    end
  end
end
