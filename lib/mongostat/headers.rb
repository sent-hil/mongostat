require "time"

module Mongostat
  class << self
    to_i = proc {|x| x.to_i }

    pipes = proc do |x|
      to_i.call(x.gsub(/\|./, ""))
    end

    locked = proc do |x|
      result = x.split(":")
      {"db" => result[0], "locked" => to_i.call(result[1])}
    end

    res = proc do |x|
      to_i.call(x.gsub("g",""))
    end

    time = proc {|x| Time.parse(x) }

    HEADERS = {
      "insert"  => to_i,
      "query"   => to_i,
      "update"  => to_i,
      "delete"  => to_i,
      "getmore" => to_i,
      "command" => pipes,
      "flushes" => to_i,
      "mapped"  => to_i,
      "vsize"   => to_i,
      "res"     => res,
      "faults"  => to_i,
      "locked"  => locked,
      "idxmiss" => to_i,
      "qr|qw"   => pipes,
      "ar|aw"   => pipes,
      "netIn"   => to_i,
      "netOut"  => to_i,
      "conn"    => to_i,
      "set"     => nil,
      "repl"    => nil,
      "time"    => time,
    }
  end
end
