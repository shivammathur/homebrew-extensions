# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/1ca91c2bd84fd6596460eacd541c0867b523d73b.tar.gz"
  version "7.0.33"
  sha256 "f198b54226f4c3e0b24d8e4b50e748e1fdf92c41db3cb01c6ff3c2287ee61612"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_sonoma:   "0b941f789f07f042a41f706170493a9740ad03291dbc8d969cb4b41609d4f779"
    sha256 cellar: :any,                 arm64_ventura:  "f2fc2c8f369abe4421d86eea472acb410ef1477ebc3219e931555f26c85fcf9f"
    sha256 cellar: :any,                 arm64_monterey: "cd6089c2800882959d5d16c89e3fc760ffa633bb70633509d99ac5d703d7e151"
    sha256 cellar: :any,                 ventura:        "c6c99b16c3383d2c9f5a64360121fb919fec991e1eb4fe12d0f097365516f14a"
    sha256 cellar: :any,                 monterey:       "dcf92bd6f11cbc39c83fd55fb4ee389e2902bc1e7aa4d6b726afdb7b6d7d0997"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "21824f9d1969445096c1ebae055b4b9a3edf1dc7660903a60bf9073c4fab1edf"
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
