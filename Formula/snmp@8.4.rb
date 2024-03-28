# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/9fae55f5db8e9c1d659cdeb1b0b24cb35e56b780.tar.gz?commit=9fae55f5db8e9c1d659cdeb1b0b24cb35e56b780"
  version "8.4.0"
  sha256 "53a75acd4c4a5ba2ed08d9deb5e368ba44aae8d80517c6c2c37ea7ae7d05a982"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 34
    sha256 cellar: :any,                 arm64_sonoma:   "fbac77723a502b8b6e6f4eea1f32f89e72ee0fd24ec47dacc50aa141f461e438"
    sha256 cellar: :any,                 arm64_ventura:  "4b535006c3ca5fdcd6f4cf58c4864c1b0dc3511536462635c3489bd1904061ed"
    sha256 cellar: :any,                 arm64_monterey: "8bedcf99ac003072d3e721009107e38f52e7cc4a97e613b6a2f677c0a7bd1af8"
    sha256 cellar: :any,                 ventura:        "fb9dd2a1e75e4d7f543828690298ee17f6644c945aee1e49408e9a5c018941c2"
    sha256 cellar: :any,                 monterey:       "78e100c4ffa212b7402c0ac9d3daf14bcb9c32ccb6fa779488ddb270ad79e9b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0dce2b00eaf86c8bbb91e3d968b9f002d7fa9896327872c9f87c08c630ed0c92"
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
