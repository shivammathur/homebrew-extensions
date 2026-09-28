# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT87 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/55186063b4ebb86103ef2a59dc63e347f7bb231d.tar.gz"
  sha256 "749b4cf78da90b69233541988e041d02fd3b6c92f61e1ff9e6c46d80c7868bab"
  version "3.5.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_golden_gate: "ac18a8b078e6ce786955812ad329830fccf79c8aea7457246c946017ae2e6d91"
    sha256 arm64_tahoe:       "082e3c00469eed9da416fcde1cb5af211dbc8fc48f0252aa906fc4abcb644df5"
    sha256 arm64_sequoia:     "bec67e0d62c93703829e5ae85fd0fb211ab564511519fba634adacd07240e3c2"
    sha256 arm64_linux:       "89f4b6148765a6510ba693b38703de9745f31b39027f22343055e01fd7e4de4d"
    sha256 x86_64_linux:      "99eff5f885138167502634f6f84527c6a29746d06aa6e17ee4d93c5082d7ba08"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    inreplace "config.m4" do |s|
      s.gsub! "8.7.0", "8.8.0"
      s.gsub! "80700", "80800"
    end
    inreplace "src/develop/stack.c" do |s|
      s.gsub! "INI_STR((char*) ", "zend_ini_string_literal("
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
