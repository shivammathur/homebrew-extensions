# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f4954df0c93a3a817fa7e2f4609683ba2465e371.tar.gz?commit=f4954df0c93a3a817fa7e2f4609683ba2465e371"
  version "8.5.0"
  sha256 "33b0fbb68f431b59ee8aaf98d166b24ee656d1ae87e1904cbcc991688561a8c0"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 19
    sha256 cellar: :any,                 arm64_sequoia: "c3ba39c0de2f9112ce17a7107441c412f869aa24ed9a8132f5af25b7f0c1687f"
    sha256 cellar: :any,                 arm64_sonoma:  "17e6e523ed994bbe4872afc4f2d3b2ddbb58df42e5826ebede435f5ba4481ee8"
    sha256 cellar: :any,                 arm64_ventura: "f57c01b3f8d33ef7d53a64eb7c16d18e858846678634c020ef8f0159841b269f"
    sha256 cellar: :any,                 ventura:       "cdc24e1f829af706568b58cb2f91df4cf89082c241d24f939ecb0bde71e5e79a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2925f6e42658ff5c530cfe3976402a76dd3ac977a675a7d4de6e0fc3ecc3f56d"
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
