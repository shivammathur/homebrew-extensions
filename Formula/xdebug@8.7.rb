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
    rebuild 1
    sha256 arm64_golden_gate: "73eb0551da14355788e9bd251dc4a4f04adac2a258ad7bb9ed3725f406c0e81f"
    sha256 arm64_tahoe:       "5b994caeb464bc58f50eb3fd7d86f704f967b1bd453c414b9225c07619b2ab04"
    sha256 arm64_sequoia:     "52c9af47d3f9fdc52f3feab8a7abd72e08015895bcc0c12db8644c2bc51a907c"
    sha256 arm64_linux:       "3daaf7d8596a902af6e152e3d077de16770169b5e250178fbb38aa93c0e0c7bc"
    sha256 x86_64_linux:      "c38443469081b2e1606e1897b470da3bd193263a502c2b2f3986fa68e5b6d2d8"
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
