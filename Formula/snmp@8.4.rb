# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2fe05c89806f16acd6948f3a8d72878d37d1bc23.tar.gz?commit=2fe05c89806f16acd6948f3a8d72878d37d1bc23"
  version "8.4.0"
  sha256 "c535169f6bf31017b89b15fd2e75d56e08d5911ca3340262e9ebaf696b25dab7"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 22
    sha256 cellar: :any,                 arm64_sonoma:   "3c5bc046cfd77b0011340754572f71ea787f91e60f726dddda65dc918c816b7e"
    sha256 cellar: :any,                 arm64_ventura:  "c62d5ff4da9bd7a566e264b135fd1d30eb097989d4f377e60cd2069d1eeb52c2"
    sha256 cellar: :any,                 arm64_monterey: "4c3293d4658da274644ad0b66ba304d0acb16c53d000ff7845ea16871d08f3d5"
    sha256 cellar: :any,                 ventura:        "9a6e5b998811d02bf15d5a88744d9aa1cae09b7fe60a6a10cfcd61548664e0bf"
    sha256 cellar: :any,                 monterey:       "c87fc50c51d4ed422b07a7306a96bbc7ed8270a21562fce4ab969d6b9cb10a12"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "648bc4c692c55254b964c82baa48b2c17b69c5359222682e9d767dc5eeaa311e"
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
