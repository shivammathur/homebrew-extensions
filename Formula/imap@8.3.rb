# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.31.tar.xz"
  sha256 "66410cee07f4b2baeb0843140bb2a2b52ef930b5cf9b3d6e6d158b33aae8fa37"
  head "https://github.com/php/php-src.git", branch: "PHP-8.3"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "a3ce0e86c68fe64ba739a3860d35a8b2b7099224e17984e1703eab3c144ed714"
    sha256 cellar: :any,                 arm64_sonoma:  "b7270659826026071df38119b27ea27ec8d69d05329dd5a422d03fd30306761b"
    sha256 cellar: :any,                 sonoma:        "7785992f57fbe9fa509e88c205a174ad0847d22632b5c98e9fe25a9772903f04"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bdb699cd52bd9e0609fd273233ccc830d57fdc67740e82dda924e7d0495e6fbd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8c9faeddef06bba8a5ebf78c8627a80c4a50294ea51c395707a25b007f5a26f3"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}",
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
