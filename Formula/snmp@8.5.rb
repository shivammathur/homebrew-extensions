# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/36891a677593c6b2cfcac29adae7cd26f21b754e.tar.gz?commit=36891a677593c6b2cfcac29adae7cd26f21b754e"
  version "8.5.0"
  sha256 "29cd8c6ace8e1a0bfab7dacdab0f1258d2cfd15d7b615f85cad715b7aec6a3ff"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 27
    sha256 cellar: :any,                 arm64_sequoia: "e483d43e4aecdbd0473a8ae641d9738e2176c9b1f7bd81491aa236b089b60e12"
    sha256 cellar: :any,                 arm64_sonoma:  "315e290ea58b0d157d86857c38d949f15e3d9133b44cb7557de477ccfe5eb7b1"
    sha256 cellar: :any,                 arm64_ventura: "2c2788e6a1c9275a7716938310d2d82a0fd8e6a1d586e78ec7b27eafee3725fd"
    sha256 cellar: :any,                 ventura:       "d792ed764b8224a528f846ad89a9470dbfc41c692bbecf25215878a044e3fef4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ac7cca57b1694a941e48bcafc88f6e1e6377afbfea6198be66453f08d7316ade"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6c472907fc7d7598914494849fffec68fae33c780e447d2a8557b8a1cd7291e8"
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
