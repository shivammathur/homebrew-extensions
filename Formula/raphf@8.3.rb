# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT83 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_monterey: "515539152ef0852a974cde4c279b6a9f679ee3f5216a7bc763819d9ee3b3f86f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "dc38c8c701f4ccbea97a2e9e38e2fa10d4bf16601f307c415b142e7c8a0b65fc"
    sha256 cellar: :any_skip_relocation, ventura:        "b5803f0db88e9954b32ac957517cfce2fbe00024415655cac098e83885593daf"
    sha256 cellar: :any_skip_relocation, monterey:       "85c9a61e3c654436474baedd8eabe419d0f00c333e1b82a3f91238e6126da602"
    sha256 cellar: :any_skip_relocation, big_sur:        "00dfc5c1ef0f08712fb3c58950a513b6ad401e53775d9d244b256384aed66a53"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fcea9df0ceb4ef9b033e5665f492cbb3248efa50f14745ca073a7dbf00a13bc8"
  end

  def install
    Dir.chdir "raphf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
