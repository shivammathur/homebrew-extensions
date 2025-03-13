# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.5.tar.xz"
  sha256 "0d3270bbce4d9ec617befce52458b763fd461d475f1fe2ed878bb8573faed327"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.4.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 66
    sha256 cellar: :any,                 arm64_sequoia: "3ab7fdf5b98110c7dad96818be12cf574e5ada700239cbe8d6d2da22e3689ae9"
    sha256 cellar: :any,                 arm64_sonoma:  "d5b1db5f44a83f51f80e24b3dd0beca2fa9b18fd01ae02739b921a5e79a64f96"
    sha256 cellar: :any,                 arm64_ventura: "de579782cba33eff2644ed64e984a0cd08f130cc4beaecdcaa77591625f6a2d5"
    sha256 cellar: :any,                 ventura:       "f3b2e9af616429b07bbd79b0704f9300922bdcbb8b9395e92f8ba64bfbb91289"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "47a2ae1027e52848e2dabaf80d738efd95dac2c89619c728ecfa606e3b4d9871"
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
