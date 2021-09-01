# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5.6.40.tar.gz?commit=caaa673e4ca008b7fa3f91538ec553c71d2fc97d"
  sha256 "f253c467dc28a229f8c5665472ac1d5723a4d024ee879c1b1322047016bea50d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_big_sur: "fff11a9c2d36ecb632e50af00d266182a5cb498fb90765c9b160b98b7fd2c862"
    sha256 cellar: :any, big_sur:       "2451b1e955f3f7b0e070cda6c05c91524786f3d2a02eef3e215946d0dcded5cd"
    sha256 cellar: :any, catalina:      "129574f5bbbc272a168d01723d1d32b16d064c819126185a11afefdc622965ca"
  end

  depends_on "imap-uw"
  depends_on "openssl@1.1"
  depends_on "krb5"

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
