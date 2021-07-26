# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT70 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "067f68246a163708e16ea487f5441520eb553807d472904e9dcb0b83ea64906e"
    sha256 cellar: :any_skip_relocation, big_sur:       "6f9a7916360a1a0df0734354487be16e7e807eefceb986ad41f747f661e2e7ab"
    sha256 cellar: :any_skip_relocation, catalina:      "f058eb64731d701919b91f89e682b9aa13a21118201e62617b95f3a5bbf3e7a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ea2541400d73467b0c82486a4258ae82007daf76b4bb98f1c8bdd5610ccbe7db"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
