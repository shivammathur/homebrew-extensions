# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/19db02dfc0c93c3dcddf34df282ee6db125203df.tar.gz"
  version "7.1.33"
  sha256 "053573e6077d61663bb95d2130b661efa52c5b10f9379243fcbdac9ce01b1e99"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.1-security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    manifest_sha256 "a0ddab4245c5e89101ee21cc0e3d2652c835a95b2b60c39f766aec774bec0701"
    sha256 cellar: :any, arm64_golden_gate: "971a7ae0d3d3849b06aae6b6bbf9ee6385c44f26502e91e8ba56e83286e75742"
    sha256 cellar: :any, arm64_tahoe:       "c69dfc98f9acfa98e7278b336128b5bc996343386940f8234a2f89f9a6c39ad4"
    sha256 cellar: :any, arm64_sequoia:     "02608f046287ecb4b2d2fe0c58caeaeb8739ad9f5e9ee0ca595c85a2e29e6f43"
    sha256 cellar: :any, arm64_linux:       "6645de396d1ce92a8c02d7189ad1ccc0ad94d7a28d3ffac411c40e4d52d02f87"
    sha256 cellar: :any, x86_64_linux:      "1e618cedecb0337b3df3fb68ee4755d848ba3976e594b470ed6f5e9df347c4c7"
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
