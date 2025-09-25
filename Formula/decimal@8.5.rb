# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT85 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://github.com/php-decimal/ext-decimal/archive/v1.5.0.tar.gz"
  sha256 "f00455a058aa22a9c9e7e5c409ee75980068bc9b8f03b17fad39d2bca2138d5d"
  revision 1
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/decimal/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "fbc495765be28eb2ee4e4e8613d35572c7ea34d590e7ba5441a626ad35738931"
    sha256 cellar: :any,                 arm64_sequoia: "b69aae4e511fe8721ca287a5b32656db352a014266b9b1edb335b1bfb7ac2564"
    sha256 cellar: :any,                 arm64_sonoma:  "a4285495ca665ee7c3f00b8ab00b3e5c08c3c53235f19abc1867ad7b2e9c3ba0"
    sha256 cellar: :any,                 sonoma:        "bb02b1717783e1b58ca6f2d51581b2d332e10dc0676a2b23c9744fe28c9de38a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d175767f771c2bb01d5c9855575a8482e121689ce58c3fd51d43934502a80de8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6dcfff2fc6a2c9f86f17caa1f3b4a591cdff1a6241194f0e75fbf66fcdabcc26"
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
