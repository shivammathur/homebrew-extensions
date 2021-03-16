# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT81 < AbstractPhp81Extension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.6.tar.gz"
  sha256 "3be3b8af91c43db70c4893dd2552c9ee2877e9cf32f59a607846c9ceb64a173b"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 30
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e8249a9c6d9556ce8a999e0e73837c3703ae9668f4fdb56fba04d0ddf35d398c"
    sha256 cellar: :any_skip_relocation, big_sur:       "58d79ddc82276555a872b8a00aa1fb810b4544bea6bccd729f56dd41cde8bac2"
    sha256 cellar: :any_skip_relocation, catalina:      "da2e77ae4ad95c6b1c60aebbe18a0949f12c43b33946ad4857f7274c5516c96f"
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
