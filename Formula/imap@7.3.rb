# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/b9413f1c99872b744c15f807e811fd280842ed28.tar.gz"
  version "7.3.33"
  sha256 "d46f032f9253f219cafdf5d52c274bc52cca2b6af9c799fa71cdcdd7c077b298"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_monterey: "90dd33ced676c5e325db0f4d23a700a1d69cd68c7229780fe749fd467c12456a"
    sha256 cellar: :any,                 arm64_big_sur:  "9679cde8b88e70de7164f024e2f8d27092a01ad0a84dd46678a82fdff1ee0c12"
    sha256 cellar: :any,                 monterey:       "6ced074c4e065f1d555b6eb03413b832bf7269529e92495ee07ec0fbbce26204"
    sha256 cellar: :any,                 big_sur:        "f6246c0dea66f50b3d469fd76f94181c7b8cdb7b5b93325b862d8796f1a5460d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a8206e836e0c12b4c0b03b20ff2f0f752df09386960549d552665e9a2035cbf1"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
