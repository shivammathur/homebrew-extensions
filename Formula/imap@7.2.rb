# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/591bc8d42c53199ad7fe8298dce65701006a2abf.tar.gz"
  version "7.2.34"
  sha256 "6c45203a66c02bf2800b32120103e10575a0df964750ed1d2b1e7d06f7139b3e"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.2-Security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "c28cebae86ecc4ad8c9ff6e46b9c8c23a168c615cf7e78d3181054853938d21a"
    sha256 cellar: :any, arm64_tahoe:       "08ddd657e30bbde474de77f81baf3b793eef9e94b84aa879b61ac91aa71775de"
    sha256 cellar: :any, arm64_sequoia:     "c19dfd122e08477120514a6e16e4809767ac195c769da19ff54b9c02b33572eb"
    sha256 cellar: :any, arm64_linux:       "9b79f340aa24d7067568f852efdbde2d9ae6232f1a9c773d51ca3ec22d4627f2"
    sha256 cellar: :any, x86_64_linux:      "8b97c39955baf2819f3915397daaa82af11552a0defff67be3e05af92d905270"
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
