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
  revision 3
  head "https://github.com/krakjoe/pcov.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "ceb7ce2ff59d8ef7dbf3066da657b384951ac5875371b60e29435b0e6b64e188"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "7a5411170e10eabbab3163e152c7c701a58ecb5f14a2499695c90158b1a214f6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "f66c42d64b398081b241aa4e6c1c14aece988881073e672fc7a44e6f673b83ef"
    sha256 cellar: :any,                 arm64_linux:       "1084d90e43154ae2e012ace02e7d47071637ae2a19ab659d328031ef99760212"
    sha256 cellar: :any,                 x86_64_linux:      "f04d0e73c89b0cfd4778f074b4c16c5db7f2bf28edf898eeeb7436b3fc157c24"
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
