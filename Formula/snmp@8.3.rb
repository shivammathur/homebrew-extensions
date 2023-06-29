# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/961e57eb6047e0970aad3ac77f9f634593412558.tar.gz?commit=961e57eb6047e0970aad3ac77f9f634593412558"
  version "8.3.0"
  sha256 "3b0320df722465b5ebfbba2255c86767a69857c0837db08f3d49e391e8474236"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 23
    sha256 cellar: :any,                 arm64_monterey: "908af764c3ffc161c3ce8cbd4dcfeca5c1d8ffc223cbfef1b5616da8255c8069"
    sha256 cellar: :any,                 arm64_big_sur:  "91889ba162d0c9068b9548a54c51cbb801db588c5a88e257fcbd9d3eef76be02"
    sha256 cellar: :any,                 ventura:        "31422d8f1134833e98f5184b3feb4817d3a6fa5bd2585366ab86fd919fbf0bd0"
    sha256 cellar: :any,                 monterey:       "e4b2f6f21f1a7bf30cb51ecfe6cf359eb80b16f77253f9cc57f2841693e5a53c"
    sha256 cellar: :any,                 big_sur:        "a0adb8fd4d199fd4878c4f8d8ddf0476ad495bbde06643536a1a615f6e42daa8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7ac9be446b7e1c8f62483f9e45c93fbc92ece03e8690a4df72729532af6d6222"
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
