# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0d94b58d35627770446d2d6dcbb1ffb0817706b4.tar.gz?commit=0d94b58d35627770446d2d6dcbb1ffb0817706b4"
  version "8.4.0"
  sha256 "22cabd4e8c7977417df5405121085180e2364981c92cd5898d30ef78b9344fb2"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "73411f6db4fbae4cbfe48891e3631d4df16459811816212992928ebd89169778"
    sha256 cellar: :any,                 arm64_big_sur:  "26fc71f8ea82dce6370e34eb3a120b2e78e7e84b417f168b2c874c9e5df9ca32"
    sha256 cellar: :any,                 ventura:        "bb3620b4fa7c51dcca0e7374909eeeccfbcf02de841070bc35a69b82673ec1d8"
    sha256 cellar: :any,                 monterey:       "5ce86affdf1b89983dd4a1042c17453501626f12a92aa1642e2b5abb7e10b54a"
    sha256 cellar: :any,                 big_sur:        "c9bbad9b094dde06206fdd51f1500fbb895d512988c4c367194f8f7478b0490c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "831ccb2612de5581b4d1ce833bc8efb201b1b7a52a12ea0a39480df4d933d70e"
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
