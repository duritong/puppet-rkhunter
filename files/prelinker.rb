#!/usr/bin/env ruby

unless ARGV.shift == '--run'
  puts "This tool helps you to prelink binaries, that are showing up in rkhunter reports."
  puts "ATTENTION: You should only prelink these binaries if you are sure, that they are still in a proper state."
  puts
  puts "Usually, you can run this helper like this: rkhunter_prelinker --run"
  puts
  puts "It will read all the binaries to prelink from the last rkhunter.log and run prelink on them"
  exit 1
end

ran = false
`grep -E '^ .* File: ' /var/log/rkhunter/rkhunter.log | sort | uniq`.split("\n").each do |line|
  if line =~ /\s+File: (.*)/
    puts "prelink #{$1}"
    `prelink #{$1}`
    ran = true
  end
end

if ran
  puts
  puts "Prelinked a couple of files, you should rerun `rkhunter --propupdate` aswell. Do we want me to do that? (y/n)"
  puts "Attention! Only do it if you are sure, that your box is in a proper state..."
  if gets.chomp == 'y'
    `rkhunter --propupdate`
  end
end
