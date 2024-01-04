# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/f6db3727459a649d4d9912ce3fdcfec95fa6ed02.tar.gz"
  version "7.0.33"
  sha256 "0e8ab03aaad5a113b693ae3999f7ed7c750b15a514714856840b0ede3302c5ba"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "fbdc285f6f571b19446aa2d4161bceefd26c83b4436918f1fd6a60d885efdefd"
    sha256 cellar: :any,                 arm64_ventura:  "dc3252dc98858e8e8ff2c575b37917cf58981f10a60ffcd8801b2e8563f06571"
    sha256 cellar: :any,                 arm64_monterey: "448636a3dd6a26afe99ad5f2b76f1b900c36c8a23d7505e6dc1af8229158677e"
    sha256 cellar: :any,                 ventura:        "8f4824ecb89b6d7cbe085855a140723301cea3cdfb88a08e383bd2ba701f47f6"
    sha256 cellar: :any,                 monterey:       "40c4292cdb17d7646d49d3f8bac98bd2a1c5b47d765dac93f3dd08a282b0279b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9c41ed28f88c1dd27a0acf5a198d3e197794f258faea1c00deadfe109cd5660d"
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
