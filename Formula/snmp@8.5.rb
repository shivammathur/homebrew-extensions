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
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "36e5cab9a3f03ab08a2afb7e92a68e5abe65acf4006bfd28a96c31dfbec8f5a0"
    sha256 cellar: :any,                 arm64_sonoma:  "4da97896ec162b47ba78589d75a67d5d0cd74db4725fdc42ca6bbe8bf39b11f3"
    sha256 cellar: :any,                 arm64_ventura: "b4745d529151fac5128896b24b024349e1de7ff75d0dd1a93d5078d97728c4ca"
    sha256 cellar: :any,                 ventura:       "11d84dce0c55c334eef1ba4b5ae0cafca98014b97254966816bda321cd714680"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "efe43a02c9331613e3c3c8713e73858c996cadf6aa814a06bb9888c9af26f28c"
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
