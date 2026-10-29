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
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "a0679a09d5886740b324cb9a6af50773e38fe69f7211c31d6ae8db6750da4c71"
    sha256 cellar: :any, arm64_tahoe:       "5434d9dbdb47aa368f2046683fd152be4cffe2bb3ae5ded43a0b3763766286ec"
    sha256 cellar: :any, arm64_sequoia:     "d6cd832328ec25cd67f6e642f144ad4c0d8c22bb8ca8c8e56feadf3822ffa5c4"
    sha256 cellar: :any, arm64_linux:       "67c6fc8bf436d94f6fc8f00630e9f045496935d81daa16879d977f8a9bfe99f1"
    sha256 cellar: :any, x86_64_linux:      "afab624d0d041649ff6fcaaa69994f5f4a679b94589704bb775b4414dcd7be0e"
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
