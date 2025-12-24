# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4ab83a550530c864e4bef29b054f81f71874d8be.tar.gz"
  version "7.4.33"
  sha256 "1593ea9ebe9902aa1dcc5651e62de5cd38b67ac636e0e166110215592ab1f820"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "99ea7791575ae01278efd593e238fb9fdb120c1f7ed2f86b15678474070acebb"
    sha256 cellar: :any,                 arm64_sequoia: "160bac95f624aeea1415dda2538b210345737c1bf5ddd5079375bed53dd12efc"
    sha256 cellar: :any,                 arm64_sonoma:  "b7180c8df70230d5662611c71baf85c8de37102dbb9cd10e85dc9db513785646"
    sha256 cellar: :any,                 sonoma:        "291962cd0ffbb2c9a5740955640d8887a6af0472153ce8c77016b7732cf09a50"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c20d137000515d3b4c360a92b97abaead4fd2ec8299ad5d5110e96d9647ac265"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d01a9929d55a0ba83c38ff97f09ee6d0e8c771aad5fc7d467cbe831bd3661b61"
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
