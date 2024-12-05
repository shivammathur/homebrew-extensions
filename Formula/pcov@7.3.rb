# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT73 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.12.tar.gz"
  sha256 "fdd07cad8e2ff42f0c9f095d84aeef11dab0fde7a008805f61883cbcb1b3f12b"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "0c34811d9d45e41d8612b08974e769b350b5be2770fd41cdeb71ab873dc33bc4"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5e67caa4e5f201e3ca9fa498639c0e75f4e152af217d7ad71b8c56c75faf0982"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d4fd3d3d7742e2834b6583ae049227f4a8d17ffb49b191935eb87f7ee4b4d3e3"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "0c496bc6fe2dae9253be806e234fecc79c7882ae70bcce144bf20cea3ae28ea2"
    sha256 cellar: :any_skip_relocation, ventura:        "c301ad96363e892ba974cc6ca8bbad049ba0d7bc0b383ebd10f1371c16f1ce13"
    sha256 cellar: :any_skip_relocation, big_sur:        "536047f5127437b79f8923c2e2cf9d3ac8fd1dc319b461e8e5ac044a0e26865d"
    sha256 cellar: :any_skip_relocation, catalina:       "6297e4979866f7e1a74466e03cff2d458f5d8de31804ef6fd5f64e306fcced63"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "753fc3caab36b4ef9f246086c414a4947c4c6c4fe919869e4172eb27ab13f806"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
