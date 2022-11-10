# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT71 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.12.tar.gz"
  sha256 "de41f25b7d3cf707332c0069ad2a7541f0265b6689de5e99da3c2cab4bf5465e"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ca6930f6167dae02a575a7f857938c982917919699df5971b5792b27345368ce"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "64dda6cd4cf85274ef553fc965da65a3e6b411899462fc49a613315419b5c01f"
    sha256 cellar: :any_skip_relocation, monterey:       "58c7353f42cef8a09cc54b60016f33b2f6556b748f2ed156f85eb5e0f6032bdd"
    sha256 cellar: :any_skip_relocation, big_sur:        "5a930c8f706e6b8261f6374f14979983ab62fd4838e21fcfeb274c528bf56474"
    sha256 cellar: :any_skip_relocation, catalina:       "f7ad619ea4dc85685018d64a2d873f06cfe958f55e7f9c1ace482e8eb4c049fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1f194b574a1d3b01a62489d32ff6db98338a21fba675d4c49bec8218fc999f63"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
