# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a0e1cec8746cbdd9f0f2ba85a59db154efada0e105064b1e0ff066a08574eff8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "14241aa65b37c7bede2a9aec206e1b5178cede7ce5881e7c9f2a44874d2b6229"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "31071325a2c301c556ea504488835349fe5741f49837f788cf3547323f940035"
    sha256 cellar: :any_skip_relocation, sonoma:        "3b718a116ddaa07e713d1166f99dfa9e15cff27b6448a171da01f147f281d46e"
    sha256 cellar: :any_skip_relocation, ventura:       "3d7892a7d2f7475b18274df9875ee22da16d4b62bae16278cee86833936c678d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3276549ca55e3ee2e50264cdf410fd905a349672328ba8c27cd2b0e79ad2a47a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fbf7fd02a1472bb171eaa1d1ffe2bbe4169eab8d70bc9ee5661d5b55840a40d0"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
