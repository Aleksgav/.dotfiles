# frozen_string_literal: true

require 'fileutils'

# Filesystem helpers for symlinking dotfiles into place.
module Linker
  DOTFILES = File.expand_path('~/.dotfiles')

  module_function

  # Symlink DOTFILES/<src> to <dst>, Idempotent
  def link(src, dst, backup: true)
    src = File.join(DOTFILES, src)
    dst = File.expand_path(dst)
    return if File.symlink?(dst) && File.readlink(dst) == src

    backup(dst) if backup
    FileUtils.mkdir_p(File.dirname(dst))
    FileUtils.ln_s(src, dst, force: true)
  end

  # Move an existing path aside to <path>.bak. No-op when nothing is there.
  def backup(path)
    path = File.expand_path(path)
    return unless File.symlink?(path) || File.exist?(path)

    FileUtils.mv(path, "#{path}.bak", force: true)
  end

  def mkdir(dir)
    FileUtils.mkdir_p(File.expand_path(dir))
  end
end
