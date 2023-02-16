# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6059c54ed5d041b6ad6dc482950db6fd69f90627.tar.gz"
  version "7.2.34"
  sha256 "216f78257302c1ead1bf2db6140c903b8d83cb39a82e6751cda534ec7fc1ec59"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "2d3e8689b9bb34478f890c81462c44a01e4448a3afcd1a06d73e573c931f13dc"
    sha256 cellar: :any,                 arm64_big_sur:  "2e5e9a74155a7a0c8d9e792c5b287794f16d3b1cf0c6ed91014735f0b21d35d7"
    sha256 cellar: :any,                 monterey:       "aa038e6e56814f5a5d5672c3a94e880555ea8568fc2ea124675f362e1ec3b7ac"
    sha256 cellar: :any,                 big_sur:        "ee106675a4028bcbf7766a904066af8e033bacb99a7b5b97ae48e22e9f84c120"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "39f3ffa398dd3cdf9a99b8d2d472e028ede574106239b847291eb338d55f8eaf"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
