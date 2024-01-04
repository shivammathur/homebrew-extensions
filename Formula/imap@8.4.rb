# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2fe05c89806f16acd6948f3a8d72878d37d1bc23.tar.gz?commit=2fe05c89806f16acd6948f3a8d72878d37d1bc23"
  version "8.4.0"
  sha256 "c535169f6bf31017b89b15fd2e75d56e08d5911ca3340262e9ebaf696b25dab7"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 22
    sha256 cellar: :any,                 arm64_sonoma:   "9e70f728de3158c5fc82dd0192c9b6e6a33f8dc69fb42164a90077c2fa12bd7d"
    sha256 cellar: :any,                 arm64_ventura:  "7db097b51fd8e18b7e815d2b74c671df0f98bdf667791a71d110c4c38b7e0134"
    sha256 cellar: :any,                 arm64_monterey: "f82b9173c2e65046709940e532b42ea9ccaab0f9bcdb8a5adf7c61194c508c7d"
    sha256 cellar: :any,                 ventura:        "1097f2a5636b02cd7f55d62f1afeb1d2e6278df082567d1ca997be03b2556114"
    sha256 cellar: :any,                 monterey:       "9297e9bb9f0acc1ea8b4c6382ce8b180fb2bbd6271b3ce14ac9bb51aa835bcef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fa6f012223b5432471a84d6421b5cd17efc48f7b52c1fe1e6ca0387568fd099f"
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
