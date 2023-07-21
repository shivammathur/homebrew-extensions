# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/f12d05c0fdf5c88c94d8d54fa1f925aae6e302a6.tar.gz"
  version "7.1.33"
  sha256 "3153fd11bee1ff291c9367c9544f12b3df2070bba97420a12c835505ff7000ea"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "caf40aa8e801961631c9bc9b7948afeba898b4ecde44e0a3b29eec5e760466d8"
    sha256 cellar: :any,                 arm64_big_sur:  "d5fc3d93c06c26b90cea41f16b5e4b21c275fee18a35ee72e673724ff7962c7e"
    sha256 cellar: :any,                 ventura:        "76d956fb95fea598378162c274ce0498fecebdf734b39e11e38f74d5cb69ae09"
    sha256 cellar: :any,                 monterey:       "47776c1f53bbe517cd717cb607ab4646cbf4e75712bb8f84d14dc242cb9d617c"
    sha256 cellar: :any,                 big_sur:        "1a07950344c8daee19c2707a68297b6d0af9ad16d70837672603b8a993e732ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dda037dffe325064d9884c7aa440b53b024310cea0e6ed5bbba670ae3c3036e3"
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
