# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.19.tar.xz"
  sha256 "aecd63f3ebea6768997f5c4fccd98acbf897762ed5fc25300e846197a9485c13"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "d1994b49d8dd38ccbf3d3729c89192055930dcbadc49dfcf87f9f54c11a90b49"
    sha256 cellar: :any,                 arm64_ventura:  "bd0814d1f14b06323c70bc9239f739756ca97fe2fd719eeff0f7ced04acbc965"
    sha256 cellar: :any,                 arm64_monterey: "c467ff3be9c8e6b93d469c1c12e4d813d4d290939e805351ea18bc319949c4e1"
    sha256 cellar: :any,                 ventura:        "ea002445832ba07817358c3387b4829284f881f0844296f2b6045485b599b3b4"
    sha256 cellar: :any,                 monterey:       "3ca4feb3c374f3dd30c428d0e71fed1eced36d4030776cb61259e9e9b9a22b4d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eb669b7eb6218e7a3bfefb631ed8ae27c7026549b311caef8386698a0481e9e5"
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
