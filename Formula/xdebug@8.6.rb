# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/5d24b43b7401bd35e68f168eb68293b363cb5b24.tar.gz"
  sha256 "28f2645e4465559d1d1e837829af200ec1ecc4ba17dadeb2c4c763960fc453ea"
  version "3.5.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256                               arm64_tahoe:   "b680645f5c15d1721b022a8c4aee113f322c0b979852560f7bc29ce005b6777e"
    sha256                               arm64_sequoia: "f68be3453959f77820579e4935209f8e453dd59ede50661a7f8e4678f0e1b05e"
    sha256                               arm64_sonoma:  "f167bded04f66215d9eb1e9dc12f59ee58aa819f312f058098e137ed96b3d4c3"
    sha256 cellar: :any_skip_relocation, sonoma:        "3727ca56780382455a9cd43721f078f1b5dda3a3d82e4ba23f224857a6a25532"
    sha256                               arm64_linux:   "a21320a68d4604935a4bdc209fbd26d114a5316f9fb07b7fadc1772a0b39ac37"
    sha256                               x86_64_linux:  "00bdd74581155e89452e94a4392f15c25ca3a50894e19de1b09a0f07c7e6bb45"
  end

  uses_from_macos "zlib"

  patch do
    url "https://github.com/shivammathur/xdebug/commit/13264e7ca3608026f710fb83c5f2314bdcc610e6.patch?full_index=1"
    sha256 "2c0ed06d8adcbdd534132bf4a30a8497a236b576d3dff4c92f1375ec0436f98b"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
