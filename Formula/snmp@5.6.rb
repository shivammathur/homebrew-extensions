# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e4e699e81f4c427582691bd0dae25f3539c3e65e.tar.gz"
  version "5.6.40"
  sha256 "95e65b163387e14ab72071e5f4676b8178298e69c4fac7eb37970dfa78daeb20"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "52212bb36f0f58b0881746d6812cf1078be39953bf9b29f8676a965c9e42590d"
    sha256 cellar: :any,                 arm64_big_sur:  "6e9c453c979300bd0e2d7e94952f4ff0a4f9472abdeae4931f7d8fabf1d2dd97"
    sha256 cellar: :any,                 ventura:        "8030f32c0de979adaaf007255021534fb95dad3068a8194db4519d8d1368ee82"
    sha256 cellar: :any,                 monterey:       "0f2b7e967eb56b538ca34e0a3c4a1ade4879568a3bb36433847169cf9dff4985"
    sha256 cellar: :any,                 big_sur:        "72ba92551051c6cc1435fe0e3e485e7cac8dccf12082395dde1dbc4cea3c3aad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "669049a8160f0347b476348e92d03f9554c235b66572c611a6f5add7e2bff35f"
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
