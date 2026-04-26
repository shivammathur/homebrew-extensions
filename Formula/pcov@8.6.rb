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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "969e783bc812f78b3c1b5601f536ef7af296e6fc63722dfe1c60f7475ac04e0c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cbba800e77e3d07f6442f3426f9f7fe2ba0dadd10b1fccff9c8922b2687de2bb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c9d1ed490e14cb62971ca6ebc0e2c4d870785e0e9c6f4cff05931a2367990cb6"
    sha256 cellar: :any_skip_relocation, sonoma:        "fb4a8f0521f106973b33909ce35e563bf9071de47022610759183b8ef606ba79"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "23f2b2b79bb7bd25928aa112e4ec701d39aad414d52bd208a8fac83ea294200c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "425da1ce5e4f7bade3e43902fe8f737fc7ad4ffe008357efb8d70c3a3c53cff6"
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
