# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/94eb3bdcbf34fb61ec66e8f949c86ed66bcbd727.tar.gz?commit=94eb3bdcbf34fb61ec66e8f949c86ed66bcbd727"
  version "8.3.0"
  sha256 "32184f1cd62a950516380bf407cf788e2144dd0bda621e6b02c7ad61b1c5a3c6"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_monterey: "c4eefc87731b20adb3892c76bf0036189f1c0ee60c2a6b29858a0023b0e8d3b9"
    sha256 cellar: :any,                 arm64_big_sur:  "d7dd6016acbb9a8a0e7b3dfea0c00b2b7e2091c7add097c13fb2b5b9edbd1170"
    sha256 cellar: :any,                 ventura:        "b2c403da3249167a6eaaf85e24eb81cc683131482ecfe5a5846d6ad8387533c9"
    sha256 cellar: :any,                 monterey:       "43c5e72ae3d1f768e5e48b0570804d84c816d0c75dbd5d79d3c33c8fda9bdd1e"
    sha256 cellar: :any,                 big_sur:        "c0ead13bbf3ce194579f4e7dc18c6612b68558c373286f79571bb5953544d409"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8f075b97fa7f87c27b6d48eccb1a0387e421057f7edde75cf0184f2c8904d5db"
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
