# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/aa452ed315b0b4af0bd84459f9fc9a65d2ecc457.tar.gz?commit=aa452ed315b0b4af0bd84459f9fc9a65d2ecc457"
  version "8.3.0"
  sha256 "20e598de49261ebfcadc63fe9cb091ebbb4f06f2ef3843bd9dabd0573c772a8e"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 22
    sha256 cellar: :any,                 arm64_sonoma:   "b5a08f1eb28b7546c6d1d1c63f2b7da7fa442b42e03ac0a82b1f40e3b3e35143"
    sha256 cellar: :any,                 arm64_ventura:  "02a9b1968a20a1f08c52b7ba514e8793202e940b8060551e9dcb88288aa9ae19"
    sha256 cellar: :any,                 arm64_monterey: "4d89effeefd8e13e79df88aea3ec9a9eb0eb3da6f763769a3732b18009a0f16c"
    sha256 cellar: :any,                 ventura:        "5477835ad696124c6f97c27205ff7920301327bbf9c62ef7679f3e3e5b764417"
    sha256 cellar: :any,                 monterey:       "115a90adb5992b51b26e3fde979afcad7c5b6361a8c2145974c842f70ce611b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ce6cd46a5e3cbb015375414a66d7408a334861c72dd4df6ba51153b430ee1c9e"
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
