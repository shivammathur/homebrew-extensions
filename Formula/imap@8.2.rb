# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.14.tar.xz"
  sha256 "763ecd39fcf51c3815af6ef6e43fa9aa0d0bd8e5a615009e5f4780c92705f583"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "49f60f7460ac4028e09dab585d24592cac955e627e388e338e15b5d9bf9ebea1"
    sha256 cellar: :any,                 arm64_ventura:  "52aefc50c0d8e8b2321a001e267df62a8ff7280ac47e9d2a67ebc7a98040947f"
    sha256 cellar: :any,                 arm64_monterey: "3fe8cf6e118afb65343e3b9600831bbd4a637a654ee523aeadedb8e64bd8958a"
    sha256 cellar: :any,                 ventura:        "3066157365ad2a13fcaf725ee7019d1a164e4739abeb1f2cb51dfe0060a5147d"
    sha256 cellar: :any,                 monterey:       "3fa77317f67723cb1268564298e5453fbe0891435e420dc6561711e08c6dd4e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b907fbdd2b0df2da531b795596944a65e84fd34be1eaa29bb5f78a84f1e35ab5"
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
