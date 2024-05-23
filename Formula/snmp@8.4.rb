# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/14b92d5181857279e71ede83b1c6f14cc9b46b90.tar.gz?commit=14b92d5181857279e71ede83b1c6f14cc9b46b90"
  version "8.4.0"
  sha256 "4c963169ae75012ea9c994b34d177f52245d322300fb16bfc4be7d18cfc24b92"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 43
    sha256 cellar: :any,                 arm64_sonoma:   "997b30ca25b442dec8c67ce2b03e3596ae3bff7fd8ad475d5c7ad1012771ea8c"
    sha256 cellar: :any,                 arm64_ventura:  "0f728f34d785f11c70eb8cd6a03fced67b2835440383b12497463c2771844e67"
    sha256 cellar: :any,                 arm64_monterey: "1192fe52d0665705e3ca7d11be3dc92d489207aa998e6dfed4f09ebd7556160d"
    sha256 cellar: :any,                 ventura:        "fcc05e6c52de94317677ce1ba23d04cb6348b7ad85562a9cef66ae9b982f9614"
    sha256 cellar: :any,                 monterey:       "4a1ad2986f8ee60a6b87b4bb97b849d2d686623c428812d0f386483129e53f9d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eb84ef8b475d49830724b8d673f2343c9ee169b34f2653c7ea130dcf5c171bd9"
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
