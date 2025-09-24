# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT86 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "c1bca3b327af158ccf9f29a8f252e63c3d01fc702205b0b1130bb8d84e5616ad"
    sha256 cellar: :any,                 arm64_sonoma:  "a3a31bdea75ac21a089b0b0cb9a01c9bcbee53265543c4c714e49153630a3a4d"
    sha256 cellar: :any,                 arm64_ventura: "7ba40d0731cba598f439824534c74f7a698c4e9d147b2b5b3b6d156a8b1ef9d3"
    sha256 cellar: :any,                 ventura:       "fe731f2c6e57b3fa2a2799074d3c6374c92a130fa532a3a44a9320232a3284f6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7f29f6b550b96e31eed7424b3ad81c899867997f179f0299c84cdc3f9b70d117"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f5d800af40f71369d807b873cb443816953ad3369d14f86414cc0114a0c3ff97"
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
