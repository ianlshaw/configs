#!/usr/bin/ruby

USAGE = 'matej_loves_switches.rb TARGET HOST KEY'

if ARGV.length != 3
  puts USAGE
  exit(1)
end

# YOUR USERNAME GOES HERE
USERNAME = ''

TARGET = ARGV[0]
HOST = ARGV[1]
KEY = ARGV[2]

COMMANDS = ['aaa new-model', "radius-server host #{HOST} key #{KEY}", 'aaa authentication dot1x default group radius', 'authentication dot1x default group radius', 'dot1x system-auth-control']


def sshwrapper(command)
  result = `ssh #{USERNAME}@#{TARGET} -t '#{command}'`
  if $?.success?
    puts "#{command} executed succesfully."
  else
    puts "#{command} failed!"
    exit(2)
  end
end

def kickassloops
  COMMANDS.each do |value|
    sshwrapper(value)
  end
end

kickassloops
