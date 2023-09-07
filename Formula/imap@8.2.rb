# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.10.tar.xz"
  sha256 "561dc4acd5386e47f25be76f2c8df6ae854756469159248313bcf276e282fbb3"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "e093a6b3d1ccbac8142e6905c46695af901650728373180f7560ff9473586495"
    sha256 cellar: :any,                 arm64_big_sur:  "aa4fb2423e2450ff1f82736793350e69276649bd1b8915ed8913bdd2a7fd0486"
    sha256 cellar: :any,                 ventura:        "77380dfb4c002bd1f75f5462bdbd2571ed1755637d3e7bd1625e81d2ebd5e623"
    sha256 cellar: :any,                 monterey:       "39a5005d0082fba343a4a85fb0b73c7821e8490ae20e49b887769507088445d8"
    sha256 cellar: :any,                 big_sur:        "da5f65588a54c7d00f0d806449ea06984235da42436589698c21ffaa43a8899c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "83f72a92c481575e38c054fbe40d63106d388977559f6ed14a6d467d2c7088f2"
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
