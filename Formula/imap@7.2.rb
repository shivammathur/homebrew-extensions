# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/77ec29c163b3db7c1588fd573f53dce809836489.tar.gz"
  version "7.2.34"
  sha256 "e1b87d268ac8aadb4e25df3feeb4bf4c6ced4b123ae99f66a926b94ae557ecff"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "78a56754fb7b951a373cca55b1369d07e3b406df29c9fd24f6505b82f799e8c9"
    sha256 cellar: :any,                 arm64_big_sur:  "30b9a8133683a87400da02cb7dab15375087cbed8d8cb8f9f07279f3868ddb02"
    sha256 cellar: :any,                 ventura:        "e94d29291e65290a9f744fbf504394a87b6e5724f45ae6f4bd7795d434c4690b"
    sha256 cellar: :any,                 monterey:       "11602769e2953763c56c33d492fe1ab9dd2b1b49b31d50226a3f3a7ca6caada8"
    sha256 cellar: :any,                 big_sur:        "a7c86eec2e25e2c4ab67cd3d4f7a8aa66e82372420f129855cd67f56a483d1a6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2ab0e8fb6e5f2d3d25cddd91c0ecc5e8b84d0ded25aa36c3d97379fdd1eea899"
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
