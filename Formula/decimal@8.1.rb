# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT81 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://github.com/php-decimal/ext-decimal/archive/v1.5.0.tar.gz"
  sha256 "f00455a058aa22a9c9e7e5c409ee75980068bc9b8f03b17fad39d2bca2138d5d"
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/decimal/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "34eb9a9994532e6a1a71db9f5b2499a08428c12b88da0a7dbc2180b60877a7e7"
    sha256 cellar: :any,                 arm64_sonoma:  "b7dbc8c3bfaceca8f434a4e86dce76bd9e9acab672e01cd90de9471c28c88c9e"
    sha256 cellar: :any,                 arm64_ventura: "cbce8ecce5bfc61a5b181a542c7376e2e01f682e6ed91800c74938b34c8ba36c"
    sha256 cellar: :any,                 ventura:       "82d4d59c1c5b20e0cc7b78ac46cb995cfef0ba6416be4846aa32b7615c11cab8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "34cddee77c18f441fcc25586bb1440a8196cfb9149f92b3c86f53f22308894a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58a1d2a9b41fb27ce889c318e8d98719fdf95503407df3841a920d98db462c54"
  end

  depends_on "mpdecimal"

  def install
    args = %W[
      --enable-decimal
      --with-libmpdec-path=#{Formula["mpdecimal"].opt_prefix}
    ]
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
