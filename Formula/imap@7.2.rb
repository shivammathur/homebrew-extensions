# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7.2.34.tar.gz?commit=7a5fd67bd0d072fe4b5f072fc91a95c4acb48893"
  sha256 "a6aac9c7631d548b7311f0872b7a9a79127792966f25bf3e61ed2e68a8a8b51a"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_big_sur: "de8639e053cf959c65ed79ddb481d8a1cdd8bbf1d79bb5a5bd3b675fd734263f"
    sha256 cellar: :any, big_sur:       "718eed548909732b25f7c34c93ed080f40e8e30de4633f127bfd84b736e9e618"
    sha256 cellar: :any, catalina:      "5a79082440efe55a09b125545771ce531614315e2511db53804501a97e2ca0d6"
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
