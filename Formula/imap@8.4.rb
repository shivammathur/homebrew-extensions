# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/pecl-mail-imap"
  url "https://pecl.php.net/get/imap-1.0.2.tgz"
  sha256 "eb6d13fe10668dbb0ad6aa424139645434d0f8b4816c69dd1b251367adb3a16c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "eb08a77c64a297c0ad232a1da35972d2a637a9b45b4809146d7d308dc95c4a9c"
    sha256 cellar: :any,                 arm64_ventura:  "85e8bf4e30b22df69b7c1ef402bdb108e4109f56190ff1194957ae7e799a3d52"
    sha256 cellar: :any,                 arm64_monterey: "136d6cefb3114ec995026e35544de3c4ec6f3c8ba44bbbd6c0aa28d21fa8ad6d"
    sha256 cellar: :any,                 ventura:        "a17cd6efd74585d374ead2411354dc4a029b87af87a9b9adc9cc7ae864c12961"
    sha256 cellar: :any,                 monterey:       "11b14f8ac30b531aeb0c65824e9ef28ff6dd4c51d29789a0ee372ef355f44815"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dd59bb10be1409fecbadc1dddbdca74cb929ecf81d0664d98afa22abdaea1377"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "imap-#{version}"
    inreplace "php_imap.c", "0, Z_L(0)", "Z_L(0)"
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
