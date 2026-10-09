# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.30.tar.xz"
  sha256 "bc90523e17af4db46157e75d0c9ef0b9d0030b0514e62c26ba7b513b8c4eb015"
  revision 1
  head "https://github.com/php/php-src.git", branch: "PHP-8.2"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "b8c1c0c169a1fcf13dc3bb3550237f44b5f1f032f321fa1aba2476f7e06c75e3"
    sha256 cellar: :any, arm64_tahoe:       "0ce71896e79da66cebb8172489deacd2043c9f1226624ce18820321e0b5affea"
    sha256 cellar: :any, arm64_sequoia:     "689df6afd624118279756deecf2776fa6e72f0fc1ebf7dbbb470ea53d0e0f034"
    sha256 cellar: :any, arm64_linux:       "03e1eb3f1dc7a0a9c1a9e40a37b6bc1ec22917160723f58faf969fac85d20bd5"
    sha256 cellar: :any, x86_64_linux:      "bb2d19978769d407fdb34ed5ea6b91b752156d5af0b18f32e2e9600890199ac0"
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
