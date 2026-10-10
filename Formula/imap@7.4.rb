# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5a576d8eb53e44aff3af9259cfd29e599f604471.tar.gz"
  version "7.4.33"
  sha256 "d82887f2166e8526ea9b1cfd8c5ecf5649718f0b6e341380d333eba8066429a4"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.4-security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "217e2778d095962da69a5196a034d4ee91e45ebbd77d2a96bb2a8d8401d1a376"
    sha256 cellar: :any, arm64_tahoe:       "d3afe1da879e297ee01c20a79d260c69f3c1b719210f31bfb4aed64ae3e5b80a"
    sha256 cellar: :any, arm64_sequoia:     "c96d541c09b39d41808a9bf440759ec02972eeceaed04459a2384ca86b315015"
    sha256 cellar: :any, arm64_linux:       "0cbcab3e45439b09388c6ca48d63b6950fd64d7562f35ec48cc1e674f3d85bfb"
    sha256 cellar: :any, x86_64_linux:      "3da7803de9396c751dc6f642f9eea98e65a5dbf3b786ced55f9868303842690d"
  end

  depends_on "krb5"
  depends_on "openssl@4"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Utils::Path.formula_opt_prefix("imap-uw")}",
           "--with-imap-ssl=#{Utils::Path.formula_opt_prefix("openssl@4")}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
