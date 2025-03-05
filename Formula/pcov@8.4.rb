# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d636a6e158c19270c56ec0f5bd881d06cc7a9d3fa3868237a3cd2239d42614eb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8490df410da1fddc8c34b74a3b1bfe65cc7cda0d0d43a77e801ae7949ceb205f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "bd22bfb12d31d25732d03f9066e22f51f759b7a128d7c876f6d8dc8f9d71348c"
    sha256 cellar: :any_skip_relocation, ventura:       "a7384d494d03fbf53bf45dd8aa0bdc6ce7563ba150dc1364de1855814b94f809"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7bf333e48742a74fb170a664a9e8effc3d546def6c67a9fc1c55101f0952d592"
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
