#!/usr/bin/ruby

require "fileutils"

DEST_DIR = File.expand_path("~/.dotfiles")
TARGETS = <<EOS
  ~/.vimfiles
  ~/.vimrc
  ~/.gitmodules
EOS

TARGETS.each { |target|
  from = File.expand_path(target.strip)
  if FileTest.exists?(from)
    puts "#{from} --> #{DEST_DIR}"
    FileUtils.cp_r(from, DEST_DIR)
  end
}
