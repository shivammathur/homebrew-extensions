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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "bb34d4c4b9f254d6b88d9b53d4f17ad5e86f91fa1e61cb8b970cc7598735f8a5"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "7cb7ff4ebdcd98657c13793bf1594e28dcac883dcbf85d376761fdddda9222de"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "ef3bf53510fc5ecf67df872a95b409cd24ef1bff15cf85626dcccac9cb9ea566"
    sha256 cellar: :any,                 arm64_linux:       "35e6b67fe07c12864663210429356b221376bd14a5cd883deda6c1d94744df60"
    sha256 cellar: :any,                 x86_64_linux:      "87cbce266d630e05a0476f9d6241adacba268c83c2ff7a81a2c85128f9e40ac7"
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
