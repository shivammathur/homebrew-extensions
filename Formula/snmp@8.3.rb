# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/96ea06a1d9b115a138bd9e16a3ecc7901ae3abf6.tar.gz?commit=96ea06a1d9b115a138bd9e16a3ecc7901ae3abf6"
  version "8.3.0"
  sha256 "dbd7f3ad581b6c760bd5215137deb582cc80608bc8968303a64c16b5aefc84a8"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 21
    sha256 cellar: :any,                 arm64_monterey: "ca1f01f6ce33a0055ffd8241d9dfd49d16bf705323db987f1e741f54788754c7"
    sha256 cellar: :any,                 arm64_big_sur:  "3b05bacfbc59aaac777da98ffcd01f21a421f2f02f51726fdb007d35cceb282c"
    sha256 cellar: :any,                 ventura:        "3ab912f9131c403bdf9f90dad411646b098f3431beada09c647818a873b1562f"
    sha256 cellar: :any,                 monterey:       "26f9ccb47029afd1f564e9c1ba7b758476cdaee646a223bcb86b6f458ac67b70"
    sha256 cellar: :any,                 big_sur:        "9496d543da383b409ab15aacf24ec6dc3611cb612dd2becc3511fd370a28fe89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "48a7818d9ece4c12c32f03702af100769851869bc974e52b318f1f2abd475923"
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
