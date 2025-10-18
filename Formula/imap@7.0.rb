# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d91f3b4e4ff74ed2432010dca9ae9ce5de781670.tar.gz"
  version "7.0.33"
  sha256 "2d80d4186c14aa7e75cca38105359eda808a512a57824462e84e96d5b1be6b5c"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.0-security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia: "5c4a0179041fda2669fc2c50563dd07e90ecd3d3a2c3276a9f6d5684e87a4690"
    sha256 cellar: :any,                 arm64_sonoma:  "b6c4a5d6b597a329bc96d17039b2a56b9d6612783ebf6823239a16ac9e8d55db"
    sha256 cellar: :any,                 arm64_ventura: "17b304740b1de8cbf6bd6080e88bbfe359e24bf59abb6cac82f968f39be666ef"
    sha256 cellar: :any,                 ventura:       "1b968b096c0cfbbeaca7cc9d29ca7e5d3140681b1e4b408b5666ea48a0c44a44"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6200bcdab9270137833975c548e5963f4a0da0072f88b13ac1a1ffce05a0c4d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a4fa92633ac3074feafa7832e436bd25ed763fa33f62ff3b41ef1aca401ee5e3"
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
