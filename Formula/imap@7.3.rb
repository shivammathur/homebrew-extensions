# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2c97539020cfaadf6998f23fd301cb5158464fbc.tar.gz"
  version "7.3.33"
  sha256 "c9bc90d6c3d7b2d3a9e17581d36382f4db3e20e3e43225db5437c52e2f2de7bf"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.3-security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia: "386697e6e311611be6c3ec1ba79713fcaf00ec094caf660cfcca9ee900b09da4"
    sha256 cellar: :any,                 arm64_sonoma:  "3cdcc49a7cb04dab0413637ff5c15e995e2a47f3e1d5c8dcb1b11904bc75b40b"
    sha256 cellar: :any,                 sonoma:        "a04f616b2cb37fadd798fc27a4fee8d2c165104950f161d699516eb813171cdf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "772d0dc6d9e0f241a025ce395947a20644c15246b3adca10f5882c10b86a250c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "233e73276f302ee3de3156f1d296b6aa54ce5c2e9c9f416eb4740dbe8deb511d"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}",
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
