# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a018c2d56b59e9b369533607cc002f9ce489dc25a73466af00f4fae3a60a0df8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0a223a29da7e23a00334f47db7d3f7c25a7457f3dd04a0c17fe0dbf4e8f66754"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b725f91dcf1e6f712ccacaf20c3a176558662d75aa1d93e61a56e2054f710a5c"
    sha256 cellar: :any_skip_relocation, sonoma:        "440c4b6813f32ab9ef22b138a29c04b08a318a8185447755d86cd3cc2968611d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c7101a6c2705addda99e871d4821d35d6903a7c4d5f2023bc2bd45005c6e4968"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bdc3438a8678efbaadb129020a9712c410fc250ed0a6b97e4dacfabc7f06a087"
  end

  def install
    patch_spl_symbols
    safe_phpize
    inreplace "pcov.c", "0, 0, 0, 0", "0, 0, 0"
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
