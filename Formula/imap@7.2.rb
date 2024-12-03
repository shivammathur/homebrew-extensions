# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/aee204b665de64862d7832726ffba80faf253746.tar.gz"
  version "7.2.34"
  sha256 "12bb8a43bf63952c05b2c4186f4534cccdb78a4f62f769789c776fdd6f506ef6"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sequoia:  "796b4a436a5ee5520f902744a125b39278d0611d08531bfb8c8a1a6945620750"
    sha256 cellar: :any,                 arm64_sonoma:   "6ef09b88eb1b381d1bc55829dfd8976bb171c3697d36b0563170a67679e56335"
    sha256 cellar: :any,                 arm64_ventura:  "e98072e0ecc0c5a3326937ffa52c2d157b73d97841ffc0dc94f18f5c58b7edc4"
    sha256 cellar: :any,                 arm64_monterey: "77185da7a461ed2a9e55920952ced07586b71506d9c9fc689a9f6cd375c23e59"
    sha256 cellar: :any,                 ventura:        "464226e55a3a2852038385ffddf2457323d8f5c26f80d1d141eee22a6915e02c"
    sha256 cellar: :any,                 monterey:       "5ffefd8cb89b6d25faceaa77ba7140a62c23069bb2d1855cc0b850968e787f30"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ffc2f48446056e12f56b35d3a10164be0c09118eb3b8f6f91a356a087d39c72d"
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
