# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/a7c5407f48a201326cf82f638150540886e853b7.tar.gz"
  version "7.3.33"
  sha256 "bd7b6d3b30779b5fb89856e5d5dc90c6fa9a332029e22c7a9c179907f1706984"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sonoma:   "6eac72b3963f2c4a4aa5f9729f930c89c012bac697f4221a441cc57e1e80897e"
    sha256 cellar: :any,                 arm64_ventura:  "75b29a77ec7a16034ca5826c4519e4ece80ce789c2f1d5af5ae75a6daa158194"
    sha256 cellar: :any,                 arm64_monterey: "97437f45bd3648ce60231b36c83dd90207c673b925bcf62074073f08150fe4ea"
    sha256 cellar: :any,                 ventura:        "d1eb4a3b0591b4b2aaaeb4ace76cb501994726683498c41ef362c136e1cf4d74"
    sha256 cellar: :any,                 monterey:       "e31694983c6a351166cda03f82acf5d3811a5eb4c8584bc05451d48330ce3420"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9ff039443325cfe4075319133fc69ff99b181933303cbbbb8929bbe7f1fa4283"
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
