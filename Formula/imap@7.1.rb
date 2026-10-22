# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/85accd17bbbe667724a4901e0b3eec4f5fabddaa.tar.gz"
  version "7.1.33"
  sha256 "f5c5326b49a1b2c0fb6049ba6e237e7ad3df4a3f75885509f591b71c15232f44"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.1-security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "af493cece4bdc18ac409725bd3ccf54368d74941ac347fc9f1971c7d3946936a"
    sha256 cellar: :any, arm64_tahoe:       "ec95b2dc15462254de4374aeb77ab56cd2506dffae1431ce5fadbb747783042d"
    sha256 cellar: :any, arm64_sequoia:     "d4ea02bc8b1db3b3ee099f0f15116619e2219f69d11db714c0e2493463f2c163"
    sha256 cellar: :any, arm64_linux:       "afe2300f4ba7b8ec7fe5763e13bc0ec094c4e2fd58c94eb40c66f79799995215"
    sha256 cellar: :any, x86_64_linux:      "ce0027092c6bd233b367a72e5a6f0ea42fa661fb659a52193fb0ae33b31bcdf1"
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
