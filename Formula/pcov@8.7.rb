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
  revision 2
  head "https://github.com/krakjoe/pcov.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "1ad4f40de661d1f7291dbbbd7bdced60a2d38e3f857ddde60a4b0a03180d4ef2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "45b08c8f83ee84169e7a57c59e9635202462377220f355f4af3bc7d6aca4cee4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "e169e54829269cb082ed752339d514ca7ba2e77d0a1d54b583021a76a6d54c0b"
    sha256 cellar: :any,                 arm64_linux:       "324537d6fb64db6ffbc35e74b120ef605c0bba5020f5464557dad94343742034"
    sha256 cellar: :any,                 x86_64_linux:      "d013472dfaf21fd25d74b3763b9c18a3fe3c5302c70f7320f550c882a034c0ba"
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
