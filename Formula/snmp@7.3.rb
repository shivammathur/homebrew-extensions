# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6e8642559e91f9f4321f9b8be3d4bacb1ebffb71.tar.gz"
  version "7.3.33"
  sha256 "20800afaac39c391c9d314a076160ffc9a7542149799b5688bbc029721b67cb1"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia: "2f1a7c53b40a9562290f5f4157cd0e7a802f6593913794e3c2c6ac72f63cdb54"
    sha256 cellar: :any,                 arm64_sonoma:  "e98db61f348cd289a9b14846fe648534343313a89623a511a8a15685b26e4b6f"
    sha256 cellar: :any,                 arm64_ventura: "b82d22492105b283f2fc653088464820a622cb88815ddc847b2850ce71ce667c"
    sha256 cellar: :any,                 ventura:       "1fff7d177b993b7d0ed59af04a5dcb72ec583f7552f43715e2d96e6edaa18a2e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d9e18daed3be53fbf4f67f9b43983b7e03528385c2db97b714efa9fe5f9dca83"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

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
