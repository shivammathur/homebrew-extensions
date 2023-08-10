# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/39cb5f05b2bfaad7008f95e1b49b21005efaa64e.tar.gz"
  version "7.4.33"
  sha256 "1ef8f9836a28715b34645aa9335f66807a510c60cbd0ed3721aa61e2e00002ef"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "693143b5cfbe7f3ecef146236acf8496f561c16b786bb51b5380f719732d0fd1"
    sha256 cellar: :any,                 arm64_big_sur:  "db26835d4ac82cfb589ae5bbcc4015b0dcf2e60d20d0572e368123d76d1edace"
    sha256 cellar: :any,                 ventura:        "5ccda295c54bbda34893a16bd12a90903f75eb8c2877e303584af6693c3a2c5a"
    sha256 cellar: :any,                 monterey:       "16ec963f6da972692784a96b045b2de015313b68e694f62186ab21000b23598e"
    sha256 cellar: :any,                 big_sur:        "90bf62738d5f69f3cdae2cea79177a1385793e81a03c68a15dc6facc6875017e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b02ecba1d163e029ae9a4313fc22dc72fc6ef7706b583c88cbaa6fdc75538e77"
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
