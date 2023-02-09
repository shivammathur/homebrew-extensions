# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/3ff8333473f79fe8255fd2e0781cd3477ebe6a25.tar.gz?commit=3ff8333473f79fe8255fd2e0781cd3477ebe6a25"
  version "8.3.0"
  sha256 "466af1dcdb8f660c1b4f4aec364834328ba68ecee978c08ed4ffa2e885d4c539"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 19
    sha256 cellar: :any,                 arm64_monterey: "abf0181c488fa39067b31b66cbf72b3b7e02a11cf47003d86b61f868353c9a92"
    sha256 cellar: :any,                 arm64_big_sur:  "e6a3c289c4b2a9029df0d5b0132ac33eba32222994cad5222f655f81947ca00d"
    sha256 cellar: :any,                 monterey:       "261e585cb054ca7d98ad2b5a935299195e9843c435f1e600c9ab2c43fd3fb521"
    sha256 cellar: :any,                 big_sur:        "800ad0b5a06c1b5fb688d142eb10e08beaf8a9d2b474eb20c20ccd1b49829c14"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b4f7b16ecd362897ee689d87a4ab3055af1e7ebb158441d9ad9b5473c287922a"
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
