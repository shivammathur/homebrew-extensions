# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/343115f58357c0314dfb22d404ba69ab54081aff.tar.gz"
  sha256 "a692db3dab5608f95fa073beddba998cb775c3b97f6f172078e6f9df6775f8cc"
  version "3.4.1"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 arm64_sequoia: "1b90b11605c0063c10071b5741cb8203f966cad03ec7444a6aa945f73bece23b"
    sha256 arm64_sonoma:  "2825d2a851ced4d40a6c9f73cccdd44f517d368d8e8d8cabd6080829b4208bee"
    sha256 arm64_ventura: "8c658dfd745124f2d9cf13dc9c5b58d6983e2f40478f3f15e4e9691b5252cff4"
    sha256 ventura:       "0ec36a482af117606dc81709445017dfe95bf0f7e5f7826ccce9ac5719247af5"
    sha256 x86_64_linux:  "4c2151bf9b293b5657fa861e7b3cfddc1e11df76904d032240c6ba449ea916d3"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
