# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.3.33.tar.xz"
  sha256 "166eaccde933381da9516a2b70ad0f447d7cec4b603d07b9a916032b215b90cc"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "8cd91d461181a0ffd5f8fc6d9ca62215c43ad09deec80fccf18c09c7428999d6"
    sha256 cellar: :any,                 big_sur:       "7084587688c6472212e7fda6b3bd8ac23eadd7f95270de79a4f17d9b3f3b6950"
    sha256 cellar: :any,                 catalina:      "053635f4a1767f1574c56cfbef2c86bbda946b5aae5fa213e2e66e311fdbe66b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3906a5c1c9db7f8fa7825313973fe8e28f14e9d4564f8389116735977c81d031"
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
