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
  revision 1
  head "https://github.com/krakjoe/pcov.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "90652bead4e1b40e63e3c3fc4d034d75d388e944f627e60934859538171ed2d8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6e321d2b327e956c9534a313ce48f5c545abd1e2e93b0e92225e006f05fd41c7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6be4545b7f31c5c558b56309276647636ad208c52f6bb9f312cc20f8059b8399"
    sha256 cellar: :any_skip_relocation, sonoma:        "63fb6be2037c26dc2758549941ef71b796492c91bf158c93ebf371d6cdaa3cbc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4160112e925f917854b2744f3dacde0e86836df38fec91bf8fa8e0b4ccb1e5ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cd35c62a64415457d8d5ebf5ebe6f94bee6520507ff617e908b5c9adc4f91346"
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
