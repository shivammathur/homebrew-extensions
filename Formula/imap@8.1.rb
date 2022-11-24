# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.13.tar.xz"
  sha256 "b15ef0ccdd6760825604b3c4e3e73558dcf87c75ef1d68ef4289d8fd261ac856"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "24d35668714a7d86e4eb2b23202c31c4fa17edf9f5f84d3d9e7283de51cf726e"
    sha256 cellar: :any,                 arm64_big_sur:  "ae5b6db476d3d1ace6e1da48eb2784c0f92798cb08f99719388c4e17a6b066df"
    sha256 cellar: :any,                 monterey:       "e96f99fc6dba36b282e24bc926a771a506c63407610532507f85e10756046826"
    sha256 cellar: :any,                 big_sur:        "b23aa3c833bec12a32a7aa1608e521e425efe9a3a1bc587e32ee7463a28ea159"
    sha256 cellar: :any,                 catalina:       "317b47b791056143aa6c6572a58af8b9e985cf21e7d8735da65806a7a65ecf10"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b12fe6a1c19314ed79e84930c4616e497970035eef0ea9d3d71e37148e8bf4b1"
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
