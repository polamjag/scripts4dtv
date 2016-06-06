#!/usr/bin/ruby
# coding: utf-8
require 'time'

open(ARGV[0], 'r') do |fin|
  puts "WEBVTT FILE"

  counter = 1

  fin.readlines.each do |line|
    m = line.match(/^Dialogue: (\d+),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),([^,]*),(.*)$/) rescue nil

    if m
      _, layer, start_time, end_time, style, actor, marginl, marginr, marginv, effect, text = *m

      actor = "<v #{actor}>" unless actor == ""

      text = text.tr('０-９ａ-ｚＡ-Ｚ', '0-9a-zA-Z').split('\n').map do |l|
        l.strip
      end.join("\n")

      cue = <<EOC

#{counter}
#{start_time}0 --> #{end_time}0
#{actor}#{text}
EOC
      puts cue

      counter += 1
    end
  end
end
