# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/3a9a950472862f6647e9da2ee056df3100697187.tar.gz?commit=3a9a950472862f6647e9da2ee056df3100697187"
  version "8.3.0"
  sha256 "ab1009f61a47b8c0bfff7748a2da97b80e2278db2da2ce4d4b5973085f6e4619"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 23
    sha256 cellar: :any,                 arm64_monterey: "cb715c062caee9c1f0e260bb2304ebda521f00b10a1a33d5fb163708de11dafc"
    sha256 cellar: :any,                 arm64_big_sur:  "a4a5a58674d0514c99451a667e438e950236974428e8d7fa2bd36d804cdefbe6"
    sha256 cellar: :any,                 monterey:       "0b4a94a3df54ad5ebabee1dd50f86580188f3dd8fa22670be405332fe5322389"
    sha256 cellar: :any,                 big_sur:        "c26578d85ee6eb7638beb72a9314bb193953cff2c9e082d4779b98d140fc4f93"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7d35a03b5e274e72fa74a46a15c975af701b7dae3cb0f4be374214e59bfea214"
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
