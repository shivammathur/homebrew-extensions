# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.21.tar.xz"
  sha256 "e634a00b0c6a8cd39e840e9fb30b5227b820b7a9ace95b7b001053c1411c4821"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "6c80c0d1f06e09863afb5fef2b3758d51e0f5c8e2d224b07317f1b42c85ffa81"
    sha256 cellar: :any,                 arm64_big_sur:  "5a2eabef40e503214f9e7806913457bc3a00d24132244b3f0d3d650b75de160d"
    sha256 cellar: :any,                 ventura:        "3c9ad5466cfaa13ebe3cd3432246bc11d5d60e82f75704b86005eec8dfb4f989"
    sha256 cellar: :any,                 monterey:       "2ba94d049c169bc1984a448c1cf874c5e8b335310665568614aba3ae62e4dc6a"
    sha256 cellar: :any,                 big_sur:        "8781873ac55f64fd3840f83790076f1e1a541148c96f0f45b3e9352c714b8373"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "59a23f522b4eb42db8abc818f1ff570f0f0c12772a28e36293cd79506feb61c9"
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
