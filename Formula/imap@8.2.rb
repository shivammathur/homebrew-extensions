# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.17.tar.xz"
  sha256 "1cc4ef733ba58f6557db648012471f1916e5bac316303aa165535bedab08ee35"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "ae027cbc68766a6ea707342cfd9d5daf453c3434cb8833026412847241b126f9"
    sha256 cellar: :any,                 arm64_ventura:  "462628455a2d028392c6cd2f5e640161584de6ec723720a3101ac898ae70a191"
    sha256 cellar: :any,                 arm64_monterey: "abac881925876cf5cd198489c1a720eb74140d6f86e8bc9510c98400c75e6d82"
    sha256 cellar: :any,                 ventura:        "9729b1b1fa94a585b16bf44300d5c98d2fcb34ac50d59d553b21c495c5b419f5"
    sha256 cellar: :any,                 monterey:       "9128d13f7b82eeb7f3fb54b1fad18a708b9b1a34565a83db1d2dd9b3f62c56eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6307a67dae4248d101617414d90681463ab3a7c998e7e9e55d5f35c3b9f8ef8d"
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
