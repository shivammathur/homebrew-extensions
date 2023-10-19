# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/221b4fe246e62c5d59f617ee4cbe6fd4c614fb5a.tar.gz?commit=221b4fe246e62c5d59f617ee4cbe6fd4c614fb5a"
  version "8.4.0"
  sha256 "aa4bbae2504daf8c2e1b9ac781a44ea179f208feb762990a49907edeaaf9266d"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sonoma:   "22c9d5d1401cdaec944ab4bbeb5b6cbeae26ebcc90982ea3b946e8d2ebb307f4"
    sha256 cellar: :any,                 arm64_ventura:  "5939d7d76c58c31fe3cefec2962ac4acd7a3746022aa3b5aae9548fbf21fa239"
    sha256 cellar: :any,                 arm64_monterey: "b117448e76dcc63a1b35350f16cbd5ff7fd82aae1c88f3abbd04664f8d4c65d5"
    sha256 cellar: :any,                 ventura:        "7097964ce19da27cf6c83fbadd579417cc0a577d1746fed2338ee2537f201662"
    sha256 cellar: :any,                 monterey:       "61b53e9d040711ded64e4ce83c6099fb7cf3d0399d757df9a73d427752b7a43a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "642a415e132a06ce0d3a0e0eff29c01aad8f5a9019ca97756ac37c4aa6e142e0"
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
