# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.17.tar.xz"
  sha256 "4e7d94bb3d144412cb8b2adeb599fb1c6c1d7b357b0d0d0478dc5ef53532ebc5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "56dcdefd0a6d2f74336a0545d2c41623c0de87fc7f49c3056e55f19d6cb7023f"
    sha256 cellar: :any,                 big_sur:       "4803a14de12a6bafbe6a92e8884c2dbee9bb2f02086f396d9e3d045d4066230d"
    sha256 cellar: :any,                 catalina:      "0f36cec042b0f75207227986ab63ecab481863d28f317ecca5b7869c43d4dd81"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "659e07eb8e2486f153d42f9e3f798e5deb75f2962f049a165669ed650ee4e61f"
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
