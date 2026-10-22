# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/f4457d3e8b14e8fd31f70dde5b19e6799fe71538.tar.gz"
  version "7.2.34"
  sha256 "2beaaef99d934c31390a83e51dd61f981004fca474aa4655573292409ce83ca4"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.2-Security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "31adc901bff6b924923e80e353e91d61cdb03175775e796211e7a270027855cb"
    sha256 cellar: :any, arm64_tahoe:       "7f66611aa76f17a23439ab824c46e01f1ee5af3fbb87d0a1cc044ad9b4e8b384"
    sha256 cellar: :any, arm64_sequoia:     "572d865835dd8bff9a139bfc6495421200c1b186753ece506452717797027b45"
    sha256 cellar: :any, arm64_linux:       "3a010cea69cef25372704573127572d391489e57b56919294dcd40f788b15a19"
    sha256 cellar: :any, x86_64_linux:      "1339d632111af2d092262bf6808e424622decd11d8eac99081cb2a9b41f23ade"
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
