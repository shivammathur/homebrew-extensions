# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7b23b9111203a96db10f8da71dccb2285d872d8c.tar.gz"
  version "5.6.40"
  sha256 "f63340f5ed259c1ed1efcc2c935dee875c77f2ffb778bc11ca2572e099108451"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any,                 arm64_monterey: "ccc7079e1437750d143d87feb3acfc7449a24d72edb1d58367af38e43f65f679"
    sha256 cellar: :any,                 arm64_big_sur:  "3ec8807ad1e31f4e9e91ad14ff7283130ec9314e8ff35342b40312c93ab38e1c"
    sha256 cellar: :any,                 ventura:        "b3293cf6606f408ef9b72cf2aa47f10654dfaf69dc7fb43329f7809bad1e8bb7"
    sha256 cellar: :any,                 monterey:       "17c318b558fb692eb2eb050fc0c05dd28b72f3f145d13c61df55279285407b0d"
    sha256 cellar: :any,                 big_sur:        "db819f72dcb59ed61bc874d49a6ccaf4ed5aa16081dc3cc0ec4e3b2a145c4c52"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2823146f23e5364bcceed047368e0a66a9f7f951af974cdc973bd11f61e7734d"
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
