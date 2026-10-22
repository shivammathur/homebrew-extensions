# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/ca7964825059d3d64b3e6854b18c60fc82ed6916.tar.gz"
  version "7.3.33"
  sha256 "6675a93f6e215cb6cf0f2af4ecc8b17f9dbe26b65588d26c550c131a6e6eff29"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.3-security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "380fd13176c2e1fab92d9de62f20da1c4f4c916ea2fe7e69b88dc3a51a5845fc"
    sha256 cellar: :any, arm64_tahoe:       "748b8438be890661021d7147393eca8cd3b55ea9cb0ec17d54925a7154ac8341"
    sha256 cellar: :any, arm64_sequoia:     "1ab14d62f0de025ef4adc708d6def95d0332481ed01b164dd84cd4b761f2810c"
    sha256 cellar: :any, arm64_linux:       "4205a04cfcdfaeb187ad1dfbe77e0d37c3641e07e59b4cb80051b1e41b7e0115"
    sha256 cellar: :any, x86_64_linux:      "2291babc2841cd1c2540da80180084066b182a0ec764624c4bf48451a4596fe8"
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
