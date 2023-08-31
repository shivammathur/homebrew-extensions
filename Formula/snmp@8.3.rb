# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8f4738f41df7d876195449fb7ea83d6ffd700afa.tar.gz?commit=8f4738f41df7d876195449fb7ea83d6ffd700afa"
  version "8.3.0"
  sha256 "af4e1eeabae1bfa72b93cea6fe23de40693259f42a997c713a1ade9cd1a74560"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_monterey: "7707d769c8beaac5110f50a71d45c13f966932dac2ada56bff071282d9201099"
    sha256 cellar: :any,                 arm64_big_sur:  "9614ea23dc260ec25d2b58cb8ab20e7832a209f07eb6c0e8422e001c0e8c09a8"
    sha256 cellar: :any,                 ventura:        "901d82fcdab77da7d434645736b9ae3a3a20672759853f984727351a4d990387"
    sha256 cellar: :any,                 monterey:       "e93791e9a38dd6c244fb6b848c199603fe75c69e4a5e72b225489114e617bc72"
    sha256 cellar: :any,                 big_sur:        "5499437835098f4aaea5223ca24ec04b95c8b33aed8e3a9e55b3d968d4086a3b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "98a7d36a69b57768b36bd2e035c1540a3ec4db9ef0f89b809527a2d5e2a45c42"
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
