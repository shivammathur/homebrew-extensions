# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e45de435814feddf8e857aeb8e08fe376c5e2b2e.tar.gz"
  version "5.6.40"
  sha256 "9b23f30cb472afd0f48891abcc22a5ad3851775e31014d9169123ee98db49945"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_monterey: "517ed2ab6ef3bd2463bb75082459c8f9f13453f52772d1047b3aa50963faf6ce"
    sha256 cellar: :any,                 arm64_big_sur:  "b7d0172b8a72d3a38dea65050c132683a037c3b0144f92b2d2270a90c4302f0f"
    sha256 cellar: :any,                 monterey:       "6258a075331797cd85023ce5a2332666c71b7e5d78ea38762249c66eb5c37f46"
    sha256 cellar: :any,                 big_sur:        "6265afe97311a61ad8b59e5a301142e14f54a9f27f6d53ae81789d91eb625cca"
    sha256 cellar: :any,                 catalina:       "dcb5388d1701f2a618e7b637bf8a73aecfca8213e33874a27b4f6e8a72c0d6e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4dd673ad1d18e1b0cdf11ae90ac43ab97f949762253a65074f7906cbdc1f4eb2"
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
