# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/78364ef97ed46c585a31c601f4e8f8330d5a95c5.tar.gz?commit=78364ef97ed46c585a31c601f4e8f8330d5a95c5"
  version "8.4.0"
  sha256 "64a37e6855b48af40f8518ddd69cd22d5a32a43dbcce7668ca45606cd29037bb"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any,                 arm64_sonoma:   "e2f860f68839f09cfd8c636b7cf9bf2e67ab1f987462f1f0fdccd77093362e45"
    sha256 cellar: :any,                 arm64_ventura:  "16212aad58eb794100dd6bacf87070c5d4a97bf73d96224a0d204be678752917"
    sha256 cellar: :any,                 arm64_monterey: "9935a37f56148e561616155ac70ba6563f75579610454a960365ac9305b2d988"
    sha256 cellar: :any,                 ventura:        "bf93fc685007f00b28676e42a56959ea815954113243d8a49a51caeada0e840c"
    sha256 cellar: :any,                 monterey:       "1e84d93258a8d92f34b9da4efad911ceb8c0298c940bbba7768af83fdaa06d7c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "289815387f9d78ef0bf01efd0d0de9db1ef9c698822be632e3d90da70349e1e1"
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
