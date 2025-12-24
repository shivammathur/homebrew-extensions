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
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.2.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "f3ae44c5ac0b414aa929236778673785936104fa1d1739032c0ad19eb24daca1"
    sha256 cellar: :any,                 arm64_sequoia: "f283363a35b51b0d25efb7ab71154ca85999b0c1b90cade1094aaaae2fd9b60c"
    sha256 cellar: :any,                 arm64_sonoma:  "341b6a843a99a2632942f60ab19a147d3fec155e8eeea36add2f7fa5fb396165"
    sha256 cellar: :any,                 sonoma:        "f40209afc8e34f39676c8d1fbed36cbb88faa060e40b862506b033c5dcd1cd35"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b66cd24ca549c645ed423f750781aac7969ff8b938b15414ff89ec5152351d9f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "34c456589d1a069dd245673573fa9707b2c890fc302171383af57301928cc714"
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
