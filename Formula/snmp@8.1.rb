# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.18.tar.xz"
  sha256 "f3553370f8ba42729a9ce75eed17a2111d32433a43b615694f6a571b8bad0e39"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "fbf182dbc52a4467788f25b0d92ffa8a2b4c8e5b6f7f2fb9f5edd7ef3e3382d4"
    sha256 cellar: :any,                 arm64_big_sur:  "55a77edb0830232c8336139e6becfac60ad411dd83bd00855dcf0d515efbd802"
    sha256 cellar: :any,                 monterey:       "d20151239dc19a6e3f9b342d438fe9c8d71f81b215fea7359749f85f9defc932"
    sha256 cellar: :any,                 big_sur:        "dbc5ae3d95c97557259ac598dd5a5bc32d97317bd91f72d51391832d00a8443b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "98656cb6857f14653723c8d7d66f37df7801f19b8a2f7ac9487d6c0bc67f6b64"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
