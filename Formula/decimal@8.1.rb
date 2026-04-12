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
    sha256 cellar: :any,                 arm64_tahoe:   "287d51a476ba49cc046be35bb0e608955b8c8c00761c4d18d1ca3dcba7b1d706"
    sha256 cellar: :any,                 arm64_sequoia: "af950c70f61dadfc5c650750ff8e0bd0ac1a57634a4fe1b10ecebb2c9a6a33c1"
    sha256 cellar: :any,                 arm64_sonoma:  "a9e8af651b4319369e60330eab158e00830a145099fca91447243590c58f59a5"
    sha256 cellar: :any,                 sonoma:        "04c2847542d8ce4eb3653667c0ac83a6b6ed959bf6924dfe3fe07965537dd894"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6ea0dac626ba1ae12af1c912c8ca8849029f11eeb636285fc4d3540f41a7b113"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7b0ecdd889a411f3270a3148ad797402dac9d1ec6644db79754c7decd858ddd0"
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
