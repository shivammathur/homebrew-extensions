# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/9717e9fd564deb5a99bf5602c4fd7386ffad45b5.tar.gz?commit=9717e9fd564deb5a99bf5602c4fd7386ffad45b5"
  version "8.3.0"
  sha256 "3e021ea7b341dda41b16f91de1d18d11fbccbceea854e77d2ad8c9f7ce4edf50"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 20
    sha256 cellar: :any,                 arm64_sonoma:   "7762dac3e70c95ac3492b0c0cde797d9b3af997e3a2003dd96bbd94adf978e68"
    sha256 cellar: :any,                 arm64_ventura:  "a0d55483879cac29f04b6fdd2613dc9f5b6cb1254dd955b001775448860804b7"
    sha256 cellar: :any,                 arm64_monterey: "f189037bf2353a7038f0e0cca0bc2ac327e668bc1bdac47d2162449e61742ffb"
    sha256 cellar: :any,                 ventura:        "c5965fa02a9480e19691e4e27eef05f4dbe4a3ab9ca06e336c4c8966d1f7ad47"
    sha256 cellar: :any,                 monterey:       "d3b33731134f82319afb3baf26c54ad0465f950748b1c025f800aff32553f60d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d45b59a3b5a21ab1d55fd0b3e85a2ef95814819db60e54009f3c85e93c36b8b1"
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
