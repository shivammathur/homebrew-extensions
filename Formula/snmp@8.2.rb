# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.29.tar.xz"
  sha256 "475f991afd2d5b901fb410be407d929bc00c46285d3f439a02c59e8b6fe3589c"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.2.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "6038810fcebf39544b9350aac923d760c61722cf6e76bfbba5fc149f330016bb"
    sha256 cellar: :any,                 arm64_sonoma:  "219212501a28ef5a6dba91c4a2e1912627c5600a86d0e1cc28149fcb59836427"
    sha256 cellar: :any,                 arm64_ventura: "fda8b83b4d719deb2edf4de305d38381e33046226dad3763378b301d08b03258"
    sha256 cellar: :any,                 ventura:       "8751cd709fdbdb77a1e6858fed74930f547d62ec7b864f0604c5e124c6e209a4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9edc7144a41ce359d904a16d1df46ea139d2dded057cb2474f902e8968e3671c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d768504f38113a475033602e83601acfda42c71180e24722e3f39aa2f56676d1"
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
