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
  revision 2
  head "https://github.com/krakjoe/pcov.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "3930ad907d18db58146a4f084351561193f9a29e7c1eb9cbe760ab1cf0665215"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "9192274011a53ccde9912e26776a75a9e8250630a353cf0a18272da5e9a14ff0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "3fc8503e81d43845eb88e67f982cc4499a9fa25a1c7812e69c463cb0804469ea"
    sha256 cellar: :any,                 arm64_linux:       "dfb0dd38aa03664689e169305c02bea3b37130619772191fb8179a6675ab89f5"
    sha256 cellar: :any,                 x86_64_linux:      "b8b50ae29799ed4e570cdfc9a09efbca2f472e7a39bfda419560358caa3247c3"
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
