# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c56202b2b1f37a474c0f779253487420311f2f42.tar.gz"
  sha256 "091e70a151ec18206aa15a69d774ea661b0d43d4ba3fbbb3f794a5e81773ffce"
  version "8.0.30"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_sequoia: "94d00883f970d5bd757a88f4f6cb7cf513510d3fdf831a066927956e1034b18e"
    sha256 cellar: :any,                 arm64_sonoma:  "cd76ccae20a2ac943c6b07454d2c0c4a9ed0856c3708df948ee4b70d37b5036d"
    sha256 cellar: :any,                 arm64_ventura: "767e119d01d986ef7cc1179696d46794865a3907082b8c5610849a98a8b228b8"
    sha256 cellar: :any,                 ventura:       "263ab42c8bf49c4aa6f3b0af3cd8ade96653e3dd56608197026a3f012ae28299"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "99fbc9b305d70ba8fbe0a7f86176dfe46aca02fc05ced63b0723946664f0c086"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a40e6058d40e37fa14bc906e430beec83b351d7fc5e0c184f5aa090e58cf79bc"
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
