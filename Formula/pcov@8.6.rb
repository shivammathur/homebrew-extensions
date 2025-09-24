# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT86 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.12.tar.gz"
  sha256 "fdd07cad8e2ff42f0c9f095d84aeef11dab0fde7a008805f61883cbcb1b3f12b"
  head "https://github.com/krakjoe/pcov.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "058a017892885e0785bec257b86175ffbd90dd5af775131de18d18dfb64889fe"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9cb66995b386a5bb6da362fc8bae39c90653cd25d17c2046bffe25036495cb85"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "115f16f4712734c32620cf080cbc0819265309209f1e3dc52d5f84e7a373ea6c"
    sha256 cellar: :any_skip_relocation, sonoma:        "452bbc8febf8cd166ed464a00fcb823a0e460b87c6eeeb9e51ea02e6ad5f6867"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "978b75e4867872eceefd76e25ba57e67c9c850664ec5c82bb0cc32baa80cb940"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b148f254e123a28262551d9b796f6e4c6beb1f16733596a6beb896af1f591735"
  end

  def install
    patch_spl_symbols
    safe_phpize
    inreplace "pcov.c", "0, 0, 0, 0", "0, 0, 0"
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
