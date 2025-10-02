# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/bcd4be7d50b3632e6191b880bd9ab458cc615b08.tar.gz?commit=bcd4be7d50b3632e6191b880bd9ab458cc615b08"
  version "8.5.0"
  sha256 "cadaba80241a241fbec08a42bd77ca64f60822d28b440e26dd91828577e50b57"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "b7a525e000dc72a5d9966187aa3a0563bba48e449bd5a95f0a8228956db1d80a"
    sha256 cellar: :any,                 arm64_sequoia: "fd81349eaee2f7bf7c906f8f487de5d2916ad96e43af01ee290521f59876b655"
    sha256 cellar: :any,                 arm64_sonoma:  "9d3b62b1bb3077165b2b5555e080f54fa72f6f51cd6037652376152dbe5241ea"
    sha256 cellar: :any,                 sonoma:        "789a35f2b52c0890a3024ac13165af2ce3ba4dc8e0697a5f7d4d613da210c0d2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a5d4c2a12a8e435288020e79852c5275fad8a6b53a12ba68c2ad873e945251e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a8e6dec5a0a7ec96273a1d7322c510a5ebfaaca86db3869abc3337accbf18584"
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
