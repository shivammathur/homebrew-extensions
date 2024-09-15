# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d4c97291002d9269dc54bbdfe7e784f8c5f1828d.tar.gz"
  version "7.3.33"
  sha256 "82cb09a0ed82e88fee690da288df8a878c8db2bc0991e796559dd79c5e05c185"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sequoia:  "62377c620274b93839746332e70998ced64c419d3deb3a1838bab314e98d62c1"
    sha256 cellar: :any,                 arm64_sonoma:   "46201c20249d6ca336905c38cb5978b4cc294b183f62705690d96401470d0ee5"
    sha256 cellar: :any,                 arm64_ventura:  "ef8e6007b4e062f206a66f4754c65d80aef1167c5b5590e2816da9f2f415378a"
    sha256 cellar: :any,                 arm64_monterey: "79218b690f3cdfa74368e1993dca9f9294deb3ce41d9bfe93d12b22d0b995479"
    sha256 cellar: :any,                 ventura:        "f13eb305c2631ec2ed6533614515ec0062fc95340ba591af9bd2b6d9a95add5d"
    sha256 cellar: :any,                 monterey:       "690056f11f926e924d26d3bf4eaa4eff3c51360c886126613992b4c931f4736f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4a14eb6b782b79ef3f8837494aba95f8c3ecbbe20b3eb9caa4c1396d6418a675"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

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
