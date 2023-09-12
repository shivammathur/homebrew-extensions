# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/6b54811547efa2b59cd50597af410773b28432ac.tar.gz?commit=6b54811547efa2b59cd50597af410773b28432ac"
  version "8.4.0"
  sha256 "4b078aae2e6ffec1f73948ba78eeb48011bc46580c2816e315a591a131ea7ffc"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "d03d9549654bd4bc5209c5bbd4915c8bed57801d1114414edbb2e3ab410c8c57"
    sha256 cellar: :any,                 arm64_big_sur:  "558de8071de2f137c34547657bbf1349c80cdfb1a1fa5624f04fce49fcb372ec"
    sha256 cellar: :any,                 ventura:        "3512ff05d69a46b66bb3652bc8080d0df5df765134042c7419f214c0fccc392e"
    sha256 cellar: :any,                 monterey:       "9049dd202e279674d2b8aeb9bdf427711acbc0982a012d1dd874f8995427f176"
    sha256 cellar: :any,                 big_sur:        "ec9dcdf8228f2d2b97e68dcff7e153032cfe5cc7034352f853fec7ff532a0242"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4be0adf8294d173b3ca5047da89fec88821b54f0670023debcbc8cf34d964492"
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
