# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT71 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.19.0.tar.gz"
  sha256 "4f591dc042540d1d6a7cf3438e4e70d001c2b981acd51b87ab87a286f26e282d"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d196a6f32a929ba63ff12133b0e9cccbfe29d33e93aa88c2c0b35db566822e94"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b761f5f5ef3f4ccf3a11090517c133f19bc4e5f394a3f18d0ec651a0dae8078f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1484147a61aa699925075f340f89be92cc8ae943ab372aca914609c3b121536a"
    sha256 cellar: :any_skip_relocation, ventura:       "b07522085d21c7bda7942e3b27801dd9aca222d2c0228dcac50ca771c0e3ac57"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "26b6569fb26578a3f200cb556e5cde7f07f95fd7f6cd6291e0417cc1828a1e73"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9865117e4891230439c782698e34fe0b90ed255dec984d6e975a069302507994"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-vld"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
