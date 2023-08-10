# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/745b6220ed05d9a4a3302371b8d2ceb9ce7c287e.tar.gz"
  version "7.0.33"
  sha256 "3c7b35935e47d72e43cee7fcff2252b37000819f512235c6b314b184c588329f"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "c39fefcc7a6bf428373cd7b6ad3c287c716427607a26eb935ff82d5259bd8ad5"
    sha256 cellar: :any,                 arm64_big_sur:  "4b9feb362b17aeaa911bf8ee15e23b118ab8f4300e0e50306507a59ee2cf7ac0"
    sha256 cellar: :any,                 ventura:        "3fb93c2756877f59e2dd057ef7cef705a4869c1b20ea90c542ff78f085dd67ea"
    sha256 cellar: :any,                 monterey:       "28e94d26057876f30a90a6fb60e0a5687f28e02f5b7d699377c8aeee7cdc62a9"
    sha256 cellar: :any,                 big_sur:        "14cdbbb173e082950f2c106f8d05b54426e3913cfc95f6df88ff18a3cf75f9b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "daaf319fd595c3b3d680d56013024af664a756b7eac7ffe674868cee52b667de"
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
