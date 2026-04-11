# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT72 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://pecl.php.net/get/decimal-1.5.1.tgz"
  sha256 "8a103404e8df889f3c9626aa2668354ef1b46362071440e764765fb311b621c8"
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "2508b566fe750512b860b9ede64883f0f5e8f5ad1d1d9c6f535c026d1f84c6a5"
    sha256 cellar: :any,                 arm64_sequoia: "79e92fd9676c4b137430dd9404c1b9634cf5c01f9a55ed3babbf8278e0bef01f"
    sha256 cellar: :any,                 arm64_sonoma:  "fe0dfea551972a90c738f2deb7bc740ecdc1a9a2c8b719fee84f4dd90afb6c26"
    sha256 cellar: :any,                 sonoma:        "b003dc846c51f10ae2e71287e3c6a4fc2a505efa86d024068a8f087230a1d870"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "73debe61d41d3162e711c41111c3727a50753388b7f2937f73804c60f2a45131"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2320acb1032f2b054991d582ee9d9b1c28cf07ed907ee61ae4a8f3beb80391d7"
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
