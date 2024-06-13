# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.20.tar.xz"
  sha256 "4474cc430febef6de7be958f2c37253e5524d5c5331a7e1765cd2d2234881e50"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "195c90b8a89642be29293b88db33b25c6dcba0df725f0789069853eea10742df"
    sha256 cellar: :any,                 arm64_ventura:  "819a889427b2838c316c93dcfb4e8a279fbd16c0e7d5a80d9ed7dbc006c28288"
    sha256 cellar: :any,                 arm64_monterey: "cbb6ed0e84815b81f2bad38ec2a860ce78b941a031bbb121ced13d9a763fbd76"
    sha256 cellar: :any,                 ventura:        "88d9289953929c6bf4bf325b3ed252557602392ae104bc76f8833dae77c32422"
    sha256 cellar: :any,                 monterey:       "04716ce852bfdcbb80375256d3eadae3515b9bb6d0d6e1474a7d2a2ee56d5034"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "49bdb37020077c6bb40617cb0ea775ad232d1e99d55d664e1c245a0e578b63ff"
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
