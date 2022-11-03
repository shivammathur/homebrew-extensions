# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.25.tar.xz"
  sha256 "a291b71d0498707fc5514eb5b9513e88f0f1d4890bcdefd67282ded8a2bfb941"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "35244afba03cf4735dbb8e9625091a00e0da75c470d0410e3e3f8cdc796ede65"
    sha256 cellar: :any,                 arm64_big_sur:  "5a9ba97e6b31791519369ca9b2700224254a938dc5fcf549f82e18bb73e5598b"
    sha256 cellar: :any,                 monterey:       "437f9ea730123a74a9f3be613328d02aa7bfcf93de08ccb9835baf7ab88e1fd2"
    sha256 cellar: :any,                 big_sur:        "ee71d7e5f32a6f4043e9d8e0b0d88e6a8d88a4ffb1bb2c69c42e3182faf1ca84"
    sha256 cellar: :any,                 catalina:       "54b5dadbf80660746d535ad15725bbb33d6c8fd87996633ba99d1cb0837c250f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3cbef1393cc5b47b101295ebab99cc92a407988cba9a0ab46679177c47d53720"
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
