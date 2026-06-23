# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/196d6a472da2fca7b2249335c60b6fd60bf3c98c.tar.gz"
  version "7.4.33"
  sha256 "30f4aa482e34bb2631a66450943256b220e8c13908940bd5c5d78fe743b3e5bd"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.4-security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any,                 arm64_sequoia: "3eb4b04c7eeb789750f342328d5f60a23bb9cb566fc6c3a92ae90dc33b4f1e09"
    sha256 cellar: :any,                 arm64_sonoma:  "be82e4f4da17addbab24741dfed2cfcdb4356e8091e6a82dad44a65a76996578"
    sha256 cellar: :any,                 sonoma:        "34b215e1df0d9d10581ba89b5caf46b80dee77241ff459092e72637716740835"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fb5cf4b87edcaddc06924a9d3730e985eb240093df1fbd7d15b86b7ebb56de2b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0516289cf69b36849d8cc5aa33ff195abb483e070e594bb684277723167136ee"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Utils::Path.formula_opt_prefix("imap-uw")}",
           "--with-imap-ssl=#{Utils::Path.formula_opt_prefix("openssl@3")}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
