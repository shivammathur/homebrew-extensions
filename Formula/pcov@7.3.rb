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
  head "https://github.com/krakjoe/pcov.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "56355375b88900c74d5a6c736e5695b89f714019fc6b4ff5a13a13992461dece"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0e9a9319399e4640cd03abacc668c3c9318aa103d43269e71c2d153ecffe971c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "38894dcedf603b93d39b422776ec12c5872ff94de35b4bf2b2ea3a16a1e5d8d7"
    sha256 cellar: :any_skip_relocation, sonoma:        "5335ef7cde68562acbaaa9ae26a58dfb28d2eca0d11ba9eadecef155ad19d23f"
    sha256 cellar: :any_skip_relocation, ventura:       "d7184f9718633f6ac027f28e62530fe93533f3b0c81fd247ce54ddb6a82aef80"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "50236a121c779a10aa98a16be2450ebec36ef0bd9783c677114b69c5a9048fec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "db6e7f4aaaa4084aa1a9084f47f437e83ca102f05f1e1d613503b8a963c8307b"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
