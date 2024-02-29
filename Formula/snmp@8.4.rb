# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a74da53fc4b0b075cf762cb37d71b1e22c663c64.tar.gz?commit=a74da53fc4b0b075cf762cb37d71b1e22c663c64"
  version "8.4.0"
  sha256 "f81c0c45824bb2ca2aeb9a3a4a7cdef1fd3e0a5fa775477448aaabed81c9cb91"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 30
    sha256 cellar: :any,                 arm64_sonoma:   "bbaf2a3376bac12a448cc444db1681ea465838175308b454aa3f92a5f16b7027"
    sha256 cellar: :any,                 arm64_ventura:  "731506f3a1f644c5a2ae046b9d989a64a7666778e65c22320dc66ff196c8b737"
    sha256 cellar: :any,                 arm64_monterey: "d86eb200ddd13ae10bc94a9189dd15714cee76bf5f6c1bd6ed99fa7b93fd4c58"
    sha256 cellar: :any,                 ventura:        "c68d2ecb6782b286d8b38d2236c7f1ae4b1c235696bd3cd1f3cdb60cb715309d"
    sha256 cellar: :any,                 monterey:       "35f3ef4bfb095f757228d5a44ac9d5a7b3c16b9b31a7a23a8cec2467b4e658d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c2d6baa395e8ad023961415e553d75c65d3091d27995e8a8d22462a5bf37ab17"
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
