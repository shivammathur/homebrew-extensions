# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/599f6f196477ad5a4b59df89b1b918eee8b7827e.tar.gz?commit=599f6f196477ad5a4b59df89b1b918eee8b7827e"
  version "8.3.0"
  sha256 "20c057efbb0e5e2048ef4ae21a601ba4f50aa0804e1911dc99ff18e50f8f97f0"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_monterey: "a1030cc6a7ea44b31770500a20c70bee05f1ed8218069d24322eba44e6d7a771"
    sha256 cellar: :any,                 arm64_big_sur:  "f4f0018727e7eef697c61d9662596f5d337eaf17a3df5351738315bf6bda69d8"
    sha256 cellar: :any,                 monterey:       "543815b6c965621ccebaa42be1f1e738d5163cfcb100d0d5e201821ca03420b0"
    sha256 cellar: :any,                 big_sur:        "9a824878738176581b7c095db84a7a6eae35f587f87c6c8b4b238066779a90d5"
    sha256 cellar: :any,                 catalina:       "0bce47f3cdf4fc96d8b7eca74fef045ed6091a5a378a449b30224a2cbacabe66"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "50774bf8630ba4f2a2b39b6fb3c24abf293e2455fdad2498756009d3f67b89eb"
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
