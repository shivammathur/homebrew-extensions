# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/bad529870754ee0e214d6eea99a7f0ba42f44a03.tar.gz?commit=bad529870754ee0e214d6eea99a7f0ba42f44a03"
  version "8.3.0"
  sha256 "23873fd083a30132e10c71c8ed2e7a74b9833f13d1f119b2f58db43c79ce6b90"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_monterey: "dfa4a31b62fe2707abe170ddb70ced734cd3a745c0c5b84e7eee5dd697cbf3ef"
    sha256 cellar: :any,                 arm64_big_sur:  "913459f369c8d3a2891b47bef809810bfc083f324f7080518f305abb60f05d37"
    sha256 cellar: :any,                 ventura:        "4af60384f2da53a6bb8f3e6d6cd4f5c8ffe30e035ff57d113f06eeb776022f85"
    sha256 cellar: :any,                 monterey:       "95d512bae030cdc029a6a832a08d4aa55abcff1a23fb8647d7df6d05910dca5f"
    sha256 cellar: :any,                 big_sur:        "4d1b71794df62845b588c705938aa9bc68f8b22b6179bffdf756824ecd0a768f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "73fcd9424ecc89494c062b7df2aade104ccee5e840f895c8259384c530c9b81a"
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
