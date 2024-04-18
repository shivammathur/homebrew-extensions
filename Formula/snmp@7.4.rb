# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c6a5368db2d850e10899d237032dd4d7d116c1f0.tar.gz"
  version "7.4.33"
  sha256 "fd61fe2c759e485aedb011cc87ceb8e159dce63662dd4aded0d6aeb9231edcd8"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sonoma:   "3f68f57edcee8289bfa7f02edc49c937bd6707582cf0bd62535ba4f7c5b781c2"
    sha256 cellar: :any,                 arm64_ventura:  "e8212ad555e539cdd8efd79cb4b181a1c813229a0ff2e89c7bc26020c140951e"
    sha256 cellar: :any,                 arm64_monterey: "19c45bc7105812d351d195f4c5314907ca946da38b3297aeb3c6a912ada2aa8a"
    sha256 cellar: :any,                 ventura:        "b801ddc3be3b30935842aa44266da6b702ee507784a9192d4ac8367e2a01cb1c"
    sha256 cellar: :any,                 monterey:       "e77173d4e84f7fe4f90317b6ed3e90d14649b298c846c505bea813f201c63e80"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c26260dfc142469e85d066989b721495f56f32573a6f161e6f4e0d7bcb125bb4"
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
