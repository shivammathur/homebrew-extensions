# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2e3d13e555438d0d8110d7c7e088e7cb7e8610fb.tar.gz?commit=2e3d13e555438d0d8110d7c7e088e7cb7e8610fb"
  version "8.3.0"
  sha256 "3db2d0c0ed86cc282ee4761bd155104cec20d560de898f72eb8cb354311a3fa8"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any,                 arm64_monterey: "4a1d2260d2e9dcc97151322ec4ae8ed9539cb551ca67756016e0d941fbdd9d46"
    sha256 cellar: :any,                 arm64_big_sur:  "81d34fad6c780604918c0c78bcf792c759ac8aa17a693bc69a3be778882f9495"
    sha256 cellar: :any,                 monterey:       "173a71489499319cc800e665e59925df328edfbd73dc021f11b629f90ee2dc68"
    sha256 cellar: :any,                 big_sur:        "e2fb9141dfb567fe6a3dc8f62e05c270b49e4b9d4b5dbbd0aad576f4b592444b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "01d28a5c822a97ba5c2fee118de9df52d09cf5ddc89f248851cb248e05286621"
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
