# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "59208665e1d7d52080e3615fb2e8c31190afa0077db257a81b300165d83d1d32"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4caea7712e1a66dc25b59c70924dd882dd42467b3a4b423429e08e56cc95ef47"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "46b180d7edb21f36fc44f9c1d1808dd6fd8a0c7510e6b87462a8da4c68a7b022"
    sha256 cellar: :any_skip_relocation, ventura:       "e070290999ec815e6ceacd6d6704b0e9095444b134cdcf54cd6babb3598d02a6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9848eb60e3abb17ed1486637bafe4fbfa9649e3d06036bfb4ee8f5af09747e1e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6cd464acc558c56c7a205923ec7fb14e65c000ee6da230ce43044a1b5b494f28"
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
