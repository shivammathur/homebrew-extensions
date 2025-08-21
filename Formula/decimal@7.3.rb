# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "b127dbc32d03b26c6c13f209b04bbb06c13aa5e54a35d03c874e30663a338068"
    sha256 cellar: :any,                 arm64_sonoma:  "bb29bc94a71e904943bd96d608ada80239f7e6d87df2cc8991dfd0e52b201984"
    sha256 cellar: :any,                 arm64_ventura: "954e8463e380dc76b5d5e562645ba86eb0b0999355b2edef2fb83d4a2f3d6356"
    sha256 cellar: :any,                 ventura:       "c012eeb548f17f78f3f3db730127ed9f5c2789522494d526df15eb0a7f1c99b0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "00880c3ea267339b158a226bad6f79550751d252b49239cc88f111d7f7b716d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5b1037c4527b188ddfc8f3e1963d6e13003d24fa0492faa4c2c4ecc28366b830"
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
