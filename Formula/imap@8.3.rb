# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7666bc52267c9024d28a064d84199960779c7080.tar.gz?commit=7666bc52267c9024d28a064d84199960779c7080"
  version "8.3.0"
  sha256 "4763718bd8c1ba758eb532be28b383cd9bd1cf2038ac886d839bf2c9b1d19b28"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_monterey: "b7d755f75d5966ed43f4929d253e04e9d3a90b062cec648a4619ce5171881a26"
    sha256 cellar: :any,                 arm64_big_sur:  "410f440c5ad3568ca453aa136035219a7cad6691e32744a32f7c955a8161c689"
    sha256 cellar: :any,                 monterey:       "2663119741a65418113955059f3f4b9af2ab801b3126afefca842b53b7479ead"
    sha256 cellar: :any,                 big_sur:        "b790909f670edf265fd8208fbe4db390341986cf29311e0d9063fd3dbacaaae5"
    sha256 cellar: :any,                 catalina:       "337f6d53e184465ff36a26a64a776a3674912b74a6098ae533ed2a270fb779c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "144a45298f387fafb140132def9d09dc6b3b886ef0a1bc19540fcee38e9e5f72"
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
