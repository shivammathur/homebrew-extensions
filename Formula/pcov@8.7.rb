# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT87 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "1dee939876c99b5ddaf7ab5d2d9cba38ba6159e1648f98a0a05506c2e0c468b8"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "7d165aa98b53b5e81498fc10bd05084597c0daf0063a803725bdecf32db38ace"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "d13847639dc22adcff6db807a5a7a435542fb58d11fbbe11d1483a1ecfaefcd0"
    sha256 cellar: :any,                 arm64_linux:       "ff1e3e0ee993bb31b9e7a1856dcbf1246921ef2c5f40ad16b9a2d5b67633e9e7"
    sha256 cellar: :any,                 x86_64_linux:      "f107fbd97b58afe821da9b004c32c8de2dab4131f10315644486fec6a18b4d81"
  end

  def install
    patch_spl_symbols
    safe_phpize
    inreplace "pcov.c", "0, 0, 0, 0", "0, 0, 0"
    inreplace "pcov.c" do |s|
      s.gsub! "INI_BOOL(", "zend_ini_bool_literal("
      s.gsub! "INI_INT(", "zend_ini_long_literal("
      s.gsub! "INI_STR(", "zend_ini_string_literal("
    end
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
