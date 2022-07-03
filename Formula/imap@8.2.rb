# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/1c753a958bca9b3c802954bbb2d0681235e4af93.tar.gz?commit=1c753a958bca9b3c802954bbb2d0681235e4af93"
  version "8.2.0"
  sha256 "cd540f3929a215d32069f818ffcc7c4ca0670fceb8d5da4cc678a9d3833eaa92"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 60
    sha256 cellar: :any,                 arm64_monterey: "51df194b957127dd137ae116a9efcb5022c271bece6af46e6f7f7c7b0c0be812"
    sha256 cellar: :any,                 arm64_big_sur:  "21f825b282ca8762dbfebfdb7ce3cebaad12412fc7ba0ea0b524bec469c0130a"
    sha256 cellar: :any,                 monterey:       "02a92d032db282c3d69fcc5095deb9c61a1ec30cbdc37e640e5c4a25f8171bf2"
    sha256 cellar: :any,                 big_sur:        "9b850ed4307646909360767875de4483e319f9ffa5541b512c6ffb22fef3fa30"
    sha256 cellar: :any,                 catalina:       "6e0b08633f8680e812d331e229d3641ff0a51987a2d659ba0b7ea8311349f341"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "965163f01c1292c0d6d923383c27407eb2652445dffd800b1fb3fa3bbc3f2f5d"
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
