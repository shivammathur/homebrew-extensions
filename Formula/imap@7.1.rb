# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/b170cdd5baaf5c6b1efd4e78f9a668f10acebc28.tar.gz"
  version "7.1.33"
  sha256 "0120b9ba5bd74c7fb2787142973da29dc6868941e63c34fdf3fd5ea954acb2cd"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.1-security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "ba07fb4377a217fd33c3350c6e6e30bf167c25e306897c7f199dedd11e1626e5"
    sha256 cellar: :any, arm64_tahoe:       "8497a99ba6388189e857dd68e23b90f3bfb58e4d78f0ecd229cec3d5be818ebc"
    sha256 cellar: :any, arm64_sequoia:     "cb3a05481148a6a1df2e73181200c87c388727433d2c633d2c6f076d14b646b5"
    sha256 cellar: :any, arm64_linux:       "d8c689cbb5296eef064fd82c05ff55c7f1acb16a899d175348f85df5d1b1e571"
    sha256 cellar: :any, x86_64_linux:      "71ffc9ef31f05f02e199b9cfa0391ef023c17a3b36c10d0a02729e0b8ef4417e"
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
