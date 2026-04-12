# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "218e7f8ece02e343ee729bc46ad6d06e627b64ae362019f59a4865658a6b18a5"
    sha256 cellar: :any,                 arm64_sequoia: "1ade6e47cf70a8cb70b813c3b7831f627bc0bd3af3ab1e66be5a8b0a7d63d19c"
    sha256 cellar: :any,                 arm64_sonoma:  "967885c6c3931da72743b998e424098ef44b9828b5975562b7e550b54303616e"
    sha256 cellar: :any,                 sonoma:        "0300a31688c2bc4dc3eee1b2d44713bb9ebf809e11c52c4ec1c64d4c1b01a1bd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e2bdab194a07594a49b7f7b9db90e2fee1d145b05c5612caf2302ff7f188c8d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "64f0390ff92acaaf4d2b3ba670482513f1fb2ea631d079935c49554488f65a9e"
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
