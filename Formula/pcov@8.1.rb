# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT81 < AbstractPhp81Extension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.8.tar.gz"
  sha256 "f67a1c1aabe798e5bb85d0ea8c7b1d27b226b066d12460da8d78b48bfc6f455e"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "30b4ed6a70455745540dbe058676c0dba54eaa724751e021faddfb6962060c00"
    sha256 cellar: :any_skip_relocation, big_sur:       "9fc2a17c5589669e73da9dfdeb3cde36cfcc5f6c7be7c1cb524081630e537ce1"
    sha256 cellar: :any_skip_relocation, catalina:      "09ed09329c322b7d155c95f15cec5e1745e3f47f7799a842492a5da1abbc5fdd"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
