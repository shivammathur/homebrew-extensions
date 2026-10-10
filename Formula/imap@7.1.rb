# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/dca4c0c085063632757e8f8d296e06aaff2159e9.tar.gz"
  version "7.1.33"
  sha256 "c16d623df64f5f4823b15880350923498ec0003af815a8c121a53b8755e14914"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.1-security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "bfcb02ec52f156933ae4aeebb5abdc316b8072c1b7e8cfa71a755717de998e6d"
    sha256 cellar: :any, arm64_tahoe:       "8072d8a545d7e8fcef415857c02dc2fa05425d111be548595d3c8cef0ca9c6aa"
    sha256 cellar: :any, arm64_sequoia:     "83e0dc2e3d5de7bf34c2d39b5a96d877451a6bc4e1f1aa6b0679fa8a0cd2be85"
    sha256 cellar: :any, arm64_linux:       "0334f474c2dc04702150ebe76bfc528633fa52fe1f92deae613cf06444df496f"
    sha256 cellar: :any, x86_64_linux:      "26ec4e834cf9caa6e5257010ea2bc388f78de5ca7a2f0d58033a0502a790f668"
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
