# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT73 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://pecl.php.net/get/decimal-1.5.1.tgz"
  sha256 "8a103404e8df889f3c9626aa2668354ef1b46362071440e764765fb311b621c8"
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "2c97084b22f9c186f29a67f7f81215092f742459e4c25b9779d0771f8072289d"
    sha256 cellar: :any,                 arm64_sequoia: "3333c46919ab088a68bb08599a18a835e508078fba30c5bbeeb8b7a6895f1fb9"
    sha256 cellar: :any,                 arm64_sonoma:  "a55a80ae4de1de3931fccfbf8a980be50c6637ebbea174d6c0a3194e7b4e89be"
    sha256 cellar: :any,                 sonoma:        "1241d2a959d1a73a0c7910f13235c85fb853cd27ce8bb6c57ba53aba092ce939"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0aa0b562d992cfd2f03749f87372bade56bbb84e21c1c07318aaa1c421e90bd4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "27919d0d69871992b657626e43fa87133879fed24388c8cd23fa29b94d903c2d"
  end

  depends_on "mpdecimal"

  def install
    args = %W[
      --enable-decimal
      --with-libmpdec-path=#{Formula["mpdecimal"].opt_prefix}
    ]
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
    Dir.chdir "decimal-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
