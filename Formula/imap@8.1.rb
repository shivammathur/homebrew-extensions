# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.6.tar.xz"
  sha256 "da38d65bb0d5dd56f711cd478204f2b62a74a2c2b0d2d523a78d6eb865b2364c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "3a6dd453a2b7c8d87fc8ee173fe2ce7096b9ad98f228c5d604566eda0c86b663"
    sha256 cellar: :any,                 arm64_big_sur:  "c1080054e21b61e4294e85334ee1b7b756fe61b249f29cb8b82ff32c01e564d2"
    sha256 cellar: :any,                 monterey:       "5aeaf264f2268cf30af7fd014b613527b59a9b3d7600c58c2625736b69f52ae2"
    sha256 cellar: :any,                 big_sur:        "7f251699bd4c3b2e0144156c3e295866768b964694beab03259d5601366a2db8"
    sha256 cellar: :any,                 catalina:       "9f0b43d803ccf52b018d74724bee3aee9b9109979c28549706802b0f58bb0be1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "be447020f1be1e98dc648b25f0b84603d7f6a7fe7c291365c043ee43cd774b9a"
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
