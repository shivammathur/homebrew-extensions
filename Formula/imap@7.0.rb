# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/da64b9b864bf43d9023d6d1d6d5b582800d72c9e.tar.gz"
  version "7.0.33"
  sha256 "c412fdeac66cb816f3f3fa5a7a6755daf3f37521d997fca771ecd40f61b22cc3"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.0-security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "d44509f8693f0c50402d26f622395b28b9769bf81315d10c36cbcb5e7d1ae2da"
    sha256 cellar: :any, arm64_tahoe:       "993be1321aa1a1055aeee1f53cb983c4c3d8dcb828febf140f05d1358bc620c9"
    sha256 cellar: :any, arm64_sequoia:     "284f77c52597ecbeaa7fd62f72a069d061f97c33bc2e515c7262b9c3a3a3d388"
    sha256 cellar: :any, arm64_linux:       "50bb95e18dac2a7f0c1bb499e315ce2b536b7567e42053aa759c765aabf08858"
    sha256 cellar: :any, x86_64_linux:      "b205681c6a3767674214fe89aa4572a4def85a1545d6b44c17cbcba827944bb8"
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
