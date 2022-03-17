# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/ec53e17adf4f1669411334750a1d47954e2bc8e3.tar.gz?commit=ec53e17adf4f1669411334750a1d47954e2bc8e3"
  version "8.2.0"
  sha256 "efccb864b96d33e85b753dc6d672c84594ed3ca06445e38dbd0b6f9769aef093"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 39
    sha256 cellar: :any,                 arm64_big_sur: "d4dc756b9f83d9e5b8659d2c475f70ab5a00b0c514d8b98e19c69307ab0839f4"
    sha256 cellar: :any,                 big_sur:       "f1eec85947017507d8a3515320a90070ba01ea8570eb843cee871acb3f81b9b4"
    sha256 cellar: :any,                 catalina:      "30af3b171185689335de46ca2c0f966e813e44b2a9bc09f089de815cc4578ac1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ac982134f572ea6dd430f26108b5f3aee23082d3f3345c7e6dc44355a4ed0896"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
