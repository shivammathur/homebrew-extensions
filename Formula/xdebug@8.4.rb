# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3ed0dc70cc66cbce35d76aaaf5672895e6f7bdff.tar.gz"
  sha256 "39ac65fa8d839758ea8b8f7402aca889ac120faa462fa49120fc5288e69539df"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 arm64_sonoma:   "ec17af6d0027cab48c1adad335ede5b451d594034c9d2dc2c8c3ecc4cff15b77"
    sha256 arm64_ventura:  "ee82afbff21a54863a25b53f8d13aec71013bf867cb3a96c25e264271fc82785"
    sha256 arm64_monterey: "fc594e5cd743080cc7ef87123054bfc8a9d19e9150a17f4bf873a3f5d531ed4e"
    sha256 ventura:        "ac26c346a0b61660bc3226e6936d5f9abfc581591cc1e4edd7bade12e4d82232"
    sha256 monterey:       "9ddb7b33d200a071709c7e1cd92a7e1db59266158b41b88d9fa45e76c345e390"
    sha256 x86_64_linux:   "610c116d8960ecfa0fd84f4f8289fc25a11d6990d8ddbf0bbb8da2661e360b19"
  end

  uses_from_macos "zlib"

  def install
    inreplace "src/lib/usefulstuff.c", "ext/standard/php_lcg.h", "ext/random/php_random.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
