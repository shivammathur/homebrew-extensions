# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.2.tar.gz"
  sha256 "3f8927d5578ae5536b966ff3dcedaecf5e8b87a8f33f7fe3a78a0a6da30f4005"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8b47c0a4e3b159b38f1baf27023a1453ece4e3911daa0aa6d806be0cd43b36dd"
    sha256 cellar: :any_skip_relocation, big_sur:       "7e310870d2a6611c185a553611f7bf8bd50f27bda249dce4df2946525835ec2d"
    sha256 cellar: :any_skip_relocation, catalina:      "29feebd67c4c6c5c0f3dfdaae0e440dbfd796176e27cffbf50b9bca3ebdd023f"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
