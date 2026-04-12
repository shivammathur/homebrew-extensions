# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT81 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://pecl.php.net/get/decimal-2.0.1.tgz"
  sha256 "026e30f71016d25f267f9b38ab80a94bed4779e05e9ff5f48d9b08bf1c18d204"
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/decimal/stable.txt"
    regex(/^(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "f029cc88fbd0963111ddc70e7e22fbc53dd4cd9bce09a206c19977c85426d012"
    sha256 cellar: :any,                 arm64_sequoia: "e930e1f877f8f88b981e60ebf8636ae08fa186dd7ad6932a04f5c1d36a9e5c4e"
    sha256 cellar: :any,                 arm64_sonoma:  "a11dbed1c23e120283d8ece95733f3acec26cdba5607c30acb2a7c0efd7a0d52"
    sha256 cellar: :any,                 sonoma:        "bf18ea21af4ff1e25835486afc9d65beb003bc0b2ccec3a1938d5e4bf1e8c004"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "121ede0cbd27b534f99247054d049f17cf2554ef66097f1b431b2ad0fbcf7681"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "75cb858982164ad9a4d60e784aa9d9c1d24dabdb18a31594139b4f0fd0333e11"
  end

  depends_on "mpdecimal"

  def install
    args = %W[
      --enable-decimal
      --with-libmpdec-path=#{Formula["mpdecimal"].opt_prefix}
    ]
    Dir.chdir "decimal-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
