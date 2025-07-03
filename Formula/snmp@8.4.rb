# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.10.tar.xz"
  sha256 "14983a9ef8800e6bc2d920739fd386054402f7976ca9cd7f711509496f0d2632"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.4.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "37bb447a1bbf07dcbcd2f55a2dadb9af82058d35d8d431b491b7abd7a11a4ce2"
    sha256 cellar: :any,                 arm64_sonoma:  "8ba349e0b7af647b31974b902cf355cb4fd3cb17d6efcda0dc49291cc9e93ae2"
    sha256 cellar: :any,                 arm64_ventura: "5588173ad97b717eb5fb2211da0ac614dafe3966bcf17e43383ea2bd5a60c3c8"
    sha256 cellar: :any,                 ventura:       "91511152c4d932b4d967a1b7e51681d4520e7706f0dfcd41e83f6128c04e0f94"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "29c7e24f6919882410963e5da874f32dda9770c0897c8119386b305ed05f6176"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "efb85d2ed930691527a6ea2391b99a727f0f277f530dbe3dc72eb2a4b9063846"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
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
