# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/b9fa9ad2990f1fac1c7b726d8c9f8b58f1c2ac69.tar.gz"
  sha256 "2265e11a442da6acdd6dfe9ffb78883a9058ea5a2a05f7a264d6188a0a2c4d1f"
  version "8.0.30"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "b8067e364433b858f86fee30f29ea978ac9fda1b431ce6ebb7ce5ae1d5465748"
    sha256 cellar: :any,                 arm64_ventura:  "4d56683798c5e8faf9c2111687d34d97c3178f9aec788228ddf7e4528458db55"
    sha256 cellar: :any,                 arm64_monterey: "ab9409353b2a3dd50e00678a8cd02e2d7e7c5e11384136e070575467e1552aca"
    sha256 cellar: :any,                 ventura:        "efe9b33271fecbdb82d8321d26575d71e0472094628d5e729497f0c44c77a950"
    sha256 cellar: :any,                 monterey:       "4dd4c2de74145652d4be7beacaeaf3538a0c8d9d1c8386d92bea50e430002ef0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "66f0078816f410277864c47c0ecbe9845f017559492d7be058484b53165e6b44"
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
