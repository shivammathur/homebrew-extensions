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
  revision 3
  head "https://github.com/krakjoe/pcov.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "53d03f1c2efa2b513385a4fa4957938511a89c8c72d9a3d0e1d50e1dd58828c7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "1c62eb627d78e9823902ae9160113563f6838974cac0ffae4f11290bb04708c0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "aab0b3c6e9eb635f5e26472110d3a68fba1da99cc3669490488c270a746fc055"
    sha256 cellar: :any,                 arm64_linux:       "5a341acd47e80c90cd08047dccb43ac5dff898df74c9e404de32c369575474d2"
    sha256 cellar: :any,                 x86_64_linux:      "565c1fa3fbc52c92d80421b50710df90edeafa9c227dcecc7ba6178019f0b698"
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
