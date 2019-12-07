#! /usr/bin/env ruby

require 'fileutils'

FileUtils.rm_rf 'puzzles'

def run(cmd)
  puts cmd if @debug
  system("#{cmd} > /dev/null 2> /dev/null")
end

def curl(cmd)
  run "curl #{cmd} -H 'authority: adventofcode.com' -H 'pragma: no-cache' -H 'cache-control: no-cache' -H 'dnt: 1' -H 'upgrade-insecure-requests: 1' -H 'user-agent: Mozilla/5.0 (X11; CrOS x86_64 12499.66.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.106 Safari/537.36' -H 'sec-fetch-user: ?1' -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' -H 'sec-fetch-site: none' -H 'sec-fetch-mode: navigate' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9,ko-KR;q=0.8,ko;q=0.7' -H 'cookie: _ga=GA1.2.987359903.1575265591; _gid=GA1.2.1287606192.1575265591; session=53616c7465645f5fd88e68fddf2e084ddd52af15d6b76607f23fb70a354fbb74ffc1ba5bbf129f0e149d169c200efc8d' --compressed"
end

if ARGV.include?('-x')
  @debug = true
end

(1..25).map(&:to_s).each do |day|
  unless curl("-f https://adventofcode.com/2019/day/#{day}")
    warn "Day #{day} not released yet?"
    exit 1
  end

  dir = "puzzles/#{day}"
  puzzle = "#{dir}/puzzle.txt"
  input = "#{dir}/input"

  FileUtils.mkdir_p(dir)
	FileUtils.mkdir_p("solutions/#{day}")

  curl "https://adventofcode.com/2019/day/#{day} -o #{puzzle}"
  curl "https://adventofcode.com/2020/day/#{day}/input -o #{input}"
end
