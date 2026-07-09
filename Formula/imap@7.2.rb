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
    rebuild 16
    sha256 cellar: :any, arm64_sequoia: "672b3e6c0a83110704d2387ab5265d06d3441e53a3c6b33dafaf0162f3d67624"
    sha256 cellar: :any, arm64_sonoma:  "e4e68977a45d590d8ba77c2d8a148699e59356f416dc061c0f77af3849c43199"
    sha256 cellar: :any, sonoma:        "6b46a935416e759858cd5463b315f06d9f0f1d3e8889931f735c510d81c6e8bc"
    sha256 cellar: :any, arm64_linux:   "4a07b0f80704d601b97deb36e358f53dfa394db90f850975094ff53a8bdc0367"
    sha256 cellar: :any, x86_64_linux:  "e86f0df2fc0c21b0877835bed1cd9af72cacce73193beaa292838eca5655cb8b"
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
