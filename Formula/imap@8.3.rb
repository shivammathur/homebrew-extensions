# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/94eb3bdcbf34fb61ec66e8f949c86ed66bcbd727.tar.gz?commit=94eb3bdcbf34fb61ec66e8f949c86ed66bcbd727"
  version "8.3.0"
  sha256 "32184f1cd62a950516380bf407cf788e2144dd0bda621e6b02c7ad61b1c5a3c6"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_monterey: "d674a1cd847a9ea111ae660978cd43dae997f8cc7019a15b5836817d6a52e7d8"
    sha256 cellar: :any,                 arm64_big_sur:  "bdd2de53cd212c269aa7bb715123f24345136ee34fdf72ed038294d5473d8971"
    sha256 cellar: :any,                 ventura:        "29e7877675af35131d2772c80a79b994a8e40194114a7708cbe4956d143e648b"
    sha256 cellar: :any,                 monterey:       "aaa802beae2013de37d4faf22855e842b05758ea51daade16d21838664da3ad1"
    sha256 cellar: :any,                 big_sur:        "e60fc5e5c020d11615f12701fe0a10fee77d6119d94a70d1496c276c2015d166"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2bd2ee96cc3916b741194e2fab2a4470ab2a5d47273b4edc475d6607a0fcfca8"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
