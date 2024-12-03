# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.31.tar.xz"
  sha256 "c4f244d46ba51c72f7d13d4f66ce6a9e9a8d6b669c51be35e01765ba58e7afca"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "d9fff5f7640ffae09ca63cad9a0db9099f08348abb8cbd70b0b602dad87df0fd"
    sha256 cellar: :any,                 arm64_sonoma:   "c533048414aaf48f106120501b473245086191a4077fed70d4424303c803c775"
    sha256 cellar: :any,                 arm64_ventura:  "c3ffaa0518d095f7cd68b0a04d30f31f686c3c18c2544af92c80306c4ffe0217"
    sha256 cellar: :any,                 arm64_monterey: "4446b114d336740aa3546f9da7261fd1f24526976aa2f35df18c694882c627d9"
    sha256 cellar: :any,                 ventura:        "e23599fc58b49c9b4bfa396a98fa21a1d28510118f53f06aa84e17d82bdfab15"
    sha256 cellar: :any,                 monterey:       "f5ea2dfcb54f3a3bfeffd67850777bf22acac869b3fc8fcc9d311eaa91ff3305"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b8c995faaacb5bbc37e77894ebb04f8760d2513b2b31b8bec7d7a2c35198af4d"
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
