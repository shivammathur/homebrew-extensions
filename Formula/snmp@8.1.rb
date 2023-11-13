# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.25.tar.xz"
  sha256 "66fdba064aa119b1463a7969571d42f4642690275d8605ab5149bcc5107e2484"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "571dcef2a410271cb69463dc17218d41e1310809db09a0a10d2c869341ff9cc1"
    sha256 cellar: :any,                 arm64_ventura:  "96ca6e679a7d5dac34e093c05407ca11dfcf8824a966f3e856efa81b4a2414a0"
    sha256 cellar: :any,                 arm64_monterey: "db252884cbf0f41bcd346a8d00d92c4f0b60848e9117adf84ebbff285f5a30c5"
    sha256 cellar: :any,                 ventura:        "913bad3ede0ba45a9ff1f54d466a10efab9dfce90742f675f20da019db20a4cf"
    sha256 cellar: :any,                 monterey:       "50d701da7294d013864eead173f5fe99d09320df172ecbb4f4ba3ac6ccd7f2ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "586477f4dfc1dda40bf9d28d79d7da1061fe3618a70c86b6a1c39cf1404b06d0"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
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
