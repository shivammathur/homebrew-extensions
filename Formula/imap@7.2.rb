# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/418ed8a42fc1ff3f1f434873c4d453713d4164ea.tar.gz"
  version "7.2.34"
  sha256 "8b8104c40d0e453088f8fe703a0ead74ffdb5a4d0deb9b102864aa206bef5d2b"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.2-Security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any, arm64_sequoia: "342dec8635ca5eb381d3aa74e87b37de22e435dcff91b368b73de5f657b24bc7"
    sha256 cellar: :any, arm64_sonoma:  "6cb4b74e1c5d016fa2d63c2a44cf3c03904808b4e58be5af633f1c9ef18ae9c2"
    sha256 cellar: :any, sonoma:        "4c0f3632864121dd8af4c82fb5ce52f49ca25e5322f97424efc7cf4d8f3df81c"
    sha256 cellar: :any, arm64_linux:   "403cc224c97925184e9dae2a4c6d39b79addb80d75f35bf67612d2807feb3e78"
    sha256 cellar: :any, x86_64_linux:  "b3c0e312adda1cf2a590d7be0d22abfc1dd33aa63342ef8def41411828ee2142"
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
           "--with-imap=shared, #{Utils::Path.formula_opt_prefix("imap-uw")}",
           "--with-imap-ssl=#{Utils::Path.formula_opt_prefix("openssl@3")}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
