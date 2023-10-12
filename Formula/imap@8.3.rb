# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/06964ab13987c3bdd38c981c87710b8fbebafc5b.tar.gz?commit=06964ab13987c3bdd38c981c87710b8fbebafc5b"
  version "8.3.0"
  sha256 "8df5ef997a76501ee5810f8f089eea2fcbc360b16fe81be3751295f8b5975e88"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 17
    sha256 cellar: :any,                 arm64_sonoma:   "460d6d2ae53ff47372fa34d500e032f70644dad262c12d3c5910ea723a90acdd"
    sha256 cellar: :any,                 arm64_ventura:  "f22342ad4cb1c488298379366f808bee4afda55a81277c6847a274481928c770"
    sha256 cellar: :any,                 arm64_monterey: "8fbf6122797b4f970578729ae5756cfe9ed4ccf022f418e24b46b3d75be3c8e2"
    sha256 cellar: :any,                 ventura:        "3b6eb862a54872fbd9f2c0798040e953c8675339f961bcd9a966fd63a8ebeddd"
    sha256 cellar: :any,                 monterey:       "9bccf3aec2e9e2631ff1782ce1b7ec4c23ca53651e3b714f080e1814757a6ad7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "57423ff56e3d95cd736b57ab0488db7989b18082824e3bd496afe01dfb9db154"
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
