# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT70 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://pecl.php.net/get/decimal-1.5.1.tgz"
  sha256 "8a103404e8df889f3c9626aa2668354ef1b46362071440e764765fb311b621c8"
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "7594d20c496d4c56fa42b83622be291aee60359bfc40e3619ee876f3b029cd01"
    sha256 cellar: :any,                 arm64_sequoia: "f65efda2dac245b64df6d48e298600eca8db5a27de606e6ab53515d6cda0a129"
    sha256 cellar: :any,                 arm64_sonoma:  "645a9907d9613f31e32865c4fdc95eea7d569b67ba9799cdff112216b85c7cfa"
    sha256 cellar: :any,                 sonoma:        "1e0f3ccd86d83fc8f9ea682b8130f293daadeac6473709982690be53c241c45f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ce69c24b21ee0fb88d2cf9bc35abfddc62f6f6510eba6ebbfa215f3f2ab3ddfe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ea3ba1cb64cd2057135eb137520da735ea7f73579d25396e234b10db937421d5"
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
