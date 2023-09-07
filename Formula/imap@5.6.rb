# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c348572b0d1b2caea46e664c9d3316bb4a74fae0.tar.gz"
  version "5.6.40"
  sha256 "290f56c9abc0a5dc2771078a655ee67d2ee5bdb3f14e438741584cc71887d1a3"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any,                 arm64_monterey: "dcc8663a6b31e05bda89ca61b2da913f21ebed26e5f82dfb2dc984e7673da5ca"
    sha256 cellar: :any,                 arm64_big_sur:  "ef6dfefcb32c0894a9e8685bcbfe058670e857cadedd7b12b8e0868f61658668"
    sha256 cellar: :any,                 ventura:        "14d5ff4f1d0c46f6154ff7fea5aa291b401f0cd5649113c54c498cb95f48a483"
    sha256 cellar: :any,                 monterey:       "d8bead86b423486d026fa0bfe20464f1d71409664829bd96d5f71c7797b557c3"
    sha256 cellar: :any,                 big_sur:        "f0dce2d82c9bb3a4bae49930936788a476c0428305f15b1d4ed3d88cd411b3e7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0860488221040cdb7b3a5c1835722a1cce4062936807c3bede97e94304dc70e1"
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
