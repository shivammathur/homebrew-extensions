# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "ef91312b74f85714e9ab1a2eef712983f92ecb51fbbce564cb2d575c0e0e07ba"
    sha256 cellar: :any,                 arm64_sonoma:  "a727bf693d8941064b149afbae11e3e1ab96fe8b20645a3199a805cf7953fdfa"
    sha256 cellar: :any,                 arm64_ventura: "7a87ea23e74bc15c2766351adf5f982b3eef595ab5a0c638710d0e31d43a1aab"
    sha256 cellar: :any,                 sonoma:        "79e5358d6cb5fc78a31c6891f597532a0bf7d3468d270629f7514d99ba6d1495"
    sha256 cellar: :any,                 ventura:       "aeb5e17886452828aea6a5b5e7ee7b5356f760cdb68639d2d2c8918ae54e2928"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cf2f82c36d9f91dce10e1c1d3c6ab8bd74f4caf4b736385a646788e8e2dff022"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cc4799f2909bfc52c55e68ac3b60aa1d385f6fbb87bad1799aeb0b50ff1bd94d"
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
