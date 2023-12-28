# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6c34dd8846d13d06f91a0d1b61bce9a941756831.tar.gz"
  version "7.1.33"
  sha256 "bd305498a5ba9e47fc60ea94fe2bb552e0833fadf04844a17bb68cc75d46eced"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_ventura:  "60b5d89154199b2543033303cc60953a7a2f33ebece4932aab74bbcb6ad407be"
    sha256 cellar: :any,                 arm64_monterey: "366f0af622838fb2828ece48fef32a3d81969952ed8d6cacf0f83ebdd0d74451"
    sha256 cellar: :any,                 arm64_big_sur:  "a3f24025f16aa03a2ad7cbc2f8c1c3655652fffff6bd0617eaeb5d0bb5fa9d16"
    sha256 cellar: :any,                 ventura:        "5edbdbb68e7a053fb04127bab39ffce0239a5fbc17e5c8d06a768d1cdf7d5335"
    sha256 cellar: :any,                 monterey:       "d8c33eeee355ed800d9eed2e28349c5b31d66872500f82aeadf2c74a4f14f80c"
    sha256 cellar: :any,                 big_sur:        "1201523c5b709a4d8fb48155d1c46aabdbfdbe6ef6d42f5a4d59338785156154"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d7edb8ec8411adc5a9998db9e3eb85d9ffbb6015a00e7d2cf204c98e38f1b39c"
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
