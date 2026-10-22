# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/76d932fdc0b984a1a8d9bd42bd04fb386e36135f.tar.gz"
  version "7.0.33"
  sha256 "c7363edcfbae285748026db1e4dc70d119fead29f49c13fc42a0067d1b093241"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.0-security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "b12fd94e926f1fc41f10e9ba098a65f4b38b57cff1af93179803bebf186133e7"
    sha256 cellar: :any, arm64_tahoe:       "7eaca07c83dda9d64e91f327f0a8597f4e9a27cd27c9ba188a1bbc8fe3611154"
    sha256 cellar: :any, arm64_sequoia:     "86c7ee0821dc2595d3a38bdbf9a0ea64a433fe14810b294064beb17474208711"
    sha256 cellar: :any, arm64_linux:       "62ce7cd6666d65f8e61393735fbe45a0c29dfc0aeab6d62f68c9a9886ce07006"
    sha256 cellar: :any, x86_64_linux:      "42e97d6626e0b18014e867281eee2ab1d74250e3d57cab6ac26c8b6a23245e3d"
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
