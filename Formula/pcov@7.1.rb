# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "50a172c957bf9f8f712dfe6a26ed536070cbd1d0e4d80361b895d856f3e0bc9b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "804adea08e59e1aa4afee34e530ebe1495be669a3d4a5eb81d0afca6fe9daa75"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "54f739eb8efe3057f691cd1c4738266979c1721caab1e63512107922dea6e820"
    sha256 cellar: :any_skip_relocation, sonoma:        "c40dd860f008d5400399cd971a05058e231d6294d69af53913c76c46fe3c3201"
    sha256 cellar: :any_skip_relocation, ventura:       "ac17945920e212455ffcff6a0d32df9f80654a1fb8ef44f7f812b0b917b3291b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "de9171c6c8be67e6bb4f9c86b532cfaa6af1e20d56cdaa24cac6186d385ef3c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "85abab2ee823f1e96473e8bfa92c8b086fa3b1074ac517ea6e307914b08b825a"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
