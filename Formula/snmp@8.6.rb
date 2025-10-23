# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT86 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f8656fae35d90f89f2cef6a32c7173aa0c6b27a8.tar.gz?commit=f8656fae35d90f89f2cef6a32c7173aa0c6b27a8"
  version "8.5.0"
  sha256 "003b8fe6673076c32342c841002ae8103db4b53a6db3f1e874dbb4ed4ac6d6df"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_tahoe:   "cce6725d84dc7cf0847b8aa7608ea088338f352c0eb8a00975ac2de8f9b0a4dc"
    sha256 cellar: :any,                 arm64_sequoia: "ffa9a91b2c0260d4b26ac6905fd334467b3bb182119da3499ff889ee3fadf6fa"
    sha256 cellar: :any,                 arm64_sonoma:  "31495023fc4e701efdeca54a82a8f7cbd3f897fd58f31d49149825a89fcace16"
    sha256 cellar: :any,                 sonoma:        "dcba7a422828f3bf4f8261ca1c2c647c0b43b1a5706d86ee71231ac8311ea617"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cf091141bd3764bf13667468774cd1b3972912d6279564df44f56c7710342a53"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "03a2056a76cac880f3f6b7252d29dc56a3bf31137974f4dc01928104dc12041f"
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
