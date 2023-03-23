# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7b4c7374c3d3adfb690d951f5224ba0f27200364.tar.gz?commit=7b4c7374c3d3adfb690d951f5224ba0f27200364"
  version "8.3.0"
  sha256 "363582e78e39d12eb88dace8140ba3198094d2f15528ba8fc64d735ae79575a0"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 24
    sha256 cellar: :any,                 arm64_monterey: "9a0c5312c49f3dbda1fe630149dbb0ab3a30ca4fc8fe0c30fa87e50fce2e6ee6"
    sha256 cellar: :any,                 arm64_big_sur:  "e4938f828bf2113c510497be9636d6580a0aa8af5c251aa0fc4bfdb8cb9c1f0e"
    sha256 cellar: :any,                 monterey:       "89029f63441ec1708dcdb2fb098087b000f63ac4aaf53b2c48fd8486df1919aa"
    sha256 cellar: :any,                 big_sur:        "5dc89dae9bc01db19991b02a7e73d7dc84a3c7a60120157551efd72a1d12fb65"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c649a9461ca854b20c9d2696953c6ae79ded9b03cf7555e0c85254806fd0928d"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
