# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2c97539020cfaadf6998f23fd301cb5158464fbc.tar.gz"
  version "7.3.33"
  sha256 "c9bc90d6c3d7b2d3a9e17581d36382f4db3e20e3e43225db5437c52e2f2de7bf"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_tahoe:   "630013ccf386de57cd0231002d77ed55434dba616fb146362e96297d6f4b3b2d"
    sha256 cellar: :any,                 arm64_sequoia: "8495c1c77b48686082350a836866a6a3b2227d994497dcb9e8bf194119499b0c"
    sha256 cellar: :any,                 arm64_sonoma:  "5cb71520ec5b3654e42e942de973cce258b6a5cbffd9fefcbc7f527495dbd8f5"
    sha256 cellar: :any,                 sonoma:        "8eadab63c174ff1577baebb6efb27661b18578e7712cecc20cee62bade70d477"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cb557c53e12fdac9dcd5dbf9d0ce2f51b220f47eceba8de61fd9059f81425449"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b21a03f305e59e383d02527caa54c607c69f626b29e7f8e865e7f0f266eace31"
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
