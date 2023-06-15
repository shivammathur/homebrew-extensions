# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/96ea06a1d9b115a138bd9e16a3ecc7901ae3abf6.tar.gz?commit=96ea06a1d9b115a138bd9e16a3ecc7901ae3abf6"
  version "8.3.0"
  sha256 "dbd7f3ad581b6c760bd5215137deb582cc80608bc8968303a64c16b5aefc84a8"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 40
    sha256 cellar: :any,                 arm64_monterey: "bbec2681cbbeec030072901c89142662c7792cf6c7b7c990e2945e136a80c808"
    sha256 cellar: :any,                 arm64_big_sur:  "ad4f4e7b781f369710c0c671647b5dddaee31ab60d5a446f5fce82de8ec48bc0"
    sha256 cellar: :any,                 ventura:        "bc9a14779d861f2660b05274ccb22e78236d3c762f432307e3915e794e5438ff"
    sha256 cellar: :any,                 monterey:       "5a239b1d1ae76d6cfff8ac11e22a0c6d8aa940ef089341c52c3fccb781797959"
    sha256 cellar: :any,                 big_sur:        "01738e9b63db0454cd0655c38eb335763d92291aa67fc682a0907d620aebb56b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "167b3511148b8247fdf1581fdcaa067a0b74a1c8c52e05d8905ccff24f27989f"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
