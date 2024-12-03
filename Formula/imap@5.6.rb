# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5a280bbf377e3926cd68960065dcbdf387dda812.tar.gz"
  version "5.6.40"
  sha256 "4709aa659ca0ec0033c3743c8083c2331a36334e56dade3a6c43983c240bcbc5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 23
    sha256 cellar: :any,                 arm64_sequoia:  "60b3ebb2e705d546c49f7bbe87141a1ce520ebefb63540cce1db52571f90d454"
    sha256 cellar: :any,                 arm64_sonoma:   "4ea993735956da2308d86ec1e362c7b7797884370e5e02c213b05355208a3cc9"
    sha256 cellar: :any,                 arm64_ventura:  "d91e665b5264b26aa010901b90a14a337f10d9f2b348ba768d11610d2ac6c585"
    sha256 cellar: :any,                 arm64_monterey: "86fb9ca69e93c135bebe62e8e0720fc6f1b674c14bcb6f595ac392dc9c5dfc56"
    sha256 cellar: :any,                 ventura:        "c1363700229eb3be41f1bc8490ce7a9d2a3eb1c64e2f1076b38117a87e53c329"
    sha256 cellar: :any,                 monterey:       "ba21eed2d43482c98231896a45d79f9bf0e646fd994121790b4a0eab0f62922b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b50c3adca163630fc5c4ccc75bde6f809251759ad03a254c147548a80d785f5c"
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
