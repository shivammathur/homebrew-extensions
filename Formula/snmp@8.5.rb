# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/6e759e079f882fe54afa6da31f9cc86e9f680bf6.tar.gz?commit=6e759e079f882fe54afa6da31f9cc86e9f680bf6"
  version "8.5.0"
  sha256 "a2ba46227254efc7fcff69c098535c2b7ebeae4866c5187802590f0dba74d864"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "ae19fddadf8f6e1ba6d64543a06ec95d285439deed10f655ddfdedae8f943a03"
    sha256 cellar: :any,                 arm64_sonoma:  "1101c9068c2c9512880769336b12b35521d9de22f5e2fc3a391d7b291d58b9d4"
    sha256 cellar: :any,                 arm64_ventura: "0b1cf0b0f26199ef98507b7e4a583b8e534fa9ef8e0e826a4df8c6ea181a2c14"
    sha256 cellar: :any,                 ventura:       "4db2852d6a7028b9476974dfb60ca11c0ab886b7e560a3c29e2d61d02fee0191"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b25adf7d30df5021471424cec654072ea82f1b3d35e82ed7c4475dadd8c1bac0"
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
