# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/20a8b119f45d569e6bfee5d58b88e03579f8cb8c.tar.gz"
  version "7.3.33"
  sha256 "291acfe57a3859077f03f3fcb6d9f5d0cbc050490f9301d584db22ee5b9e5dd4"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "66aa071689a73f94b75e8232f0237870af8bdbe0ff31f13ea84eb7d226ebe052"
    sha256 cellar: :any,                 arm64_big_sur:  "b82700458e293103d199652a72785465070df0a0c1134db517015469e2630c0c"
    sha256 cellar: :any,                 ventura:        "308368843519ebeaee73e005b2f3ec55f112b60f385e09b9fd2bea43c0d9f600"
    sha256 cellar: :any,                 monterey:       "ca6e442ed629e65bf3f2f1706e435f1214ddef285e3ac9787400cc9dfdb4a40d"
    sha256 cellar: :any,                 big_sur:        "6938b1397488ba81938c59d0fde63a6868a5b3f7280f32945d5154857d39cc84"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "41148c58d3f0bb6e4765a0a883ff11910c6fe790ee20e4e303c6a932f4797d1e"
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
