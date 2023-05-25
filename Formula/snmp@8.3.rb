# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/eb7ec15a614c20a7af278b4d2f7aec4a73a06b64.tar.gz?commit=eb7ec15a614c20a7af278b4d2f7aec4a73a06b64"
  version "8.3.0"
  sha256 "106d9589cf1558209f16eb6b3f8756425dc04a4d121a5c2085f4af0a6ab2c97b"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 17
    sha256 cellar: :any,                 arm64_monterey: "4f4e210d2181aec82703974170d9d5074cb8f717a678d2dd408927d5f40ab14b"
    sha256 cellar: :any,                 arm64_big_sur:  "bb3c76ded790ea74e223891acf75084d610a290419e9cb7431c4cafd7c11b99c"
    sha256 cellar: :any,                 ventura:        "4322f14af69bbee94b07b39ecb43f701e2c01b9bf7d6bd1f645e828d59e6333d"
    sha256 cellar: :any,                 monterey:       "287bc7322decfc6b3adec852feba2dbdf03405b685ca2bff898caace2dd569c3"
    sha256 cellar: :any,                 big_sur:        "69d26052b768760d89cf37738fd69a6ec34aca08605949a0389a0509ef4a3f85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a6b0da3da3860d6f37ab52ba27924851b96d15d997fc424be43bd5bbf981a89d"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
