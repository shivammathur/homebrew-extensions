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
    rebuild 31
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "adbccc713db6d7cf667c326a999aecccb5ad0a4a2c3b723ca91a3c1c2a1f6afb"
    sha256 cellar: :any_skip_relocation, big_sur:       "9d244352ec711f409786a507068d3bc01e886b4872cfdd79865f3b0c77a91d46"
    sha256 cellar: :any_skip_relocation, catalina:      "cc9f5b688af62adfd8f85c257a6185d548b7178cd5f6dd6e15ab1f34187e4673"
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
