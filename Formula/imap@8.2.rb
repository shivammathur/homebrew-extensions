# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.1.tar.xz"
  sha256 "650d3bd7a056cabf07f6a0f6f1dd8ba45cd369574bbeaa36de7d1ece212c17af"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 82
    sha256 cellar: :any,                 arm64_monterey: "c5797f9967c359d7a25734029e074e77104765ed0a20210ce90c478847c381a0"
    sha256 cellar: :any,                 arm64_big_sur:  "aaca73e5484e01cc2f371f78467056786c2a111838382ca28196f07e429001f6"
    sha256 cellar: :any,                 monterey:       "48e4e9ae47175d2591f59aa8f3bf4b06f4ad06611728af46ee0fecbbb2c7ffd7"
    sha256 cellar: :any,                 big_sur:        "3b96ac873ec78a20fe6c93628208bfc3236ecfcd1c795095fd35c46ad4f7b50d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6770df45913659ae453df7c325c5469f0357568834a93aff67bff628ee1d5270"
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
