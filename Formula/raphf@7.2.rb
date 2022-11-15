# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT72 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c12dd0a68f0685b4edfc22ef3a6836e21286eb39a5494ab16b4e927f36891d59"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5e5b3ba684ba2dc6cf930d1381a37746347e3209a452bdbf4e6412c8695e4d43"
    sha256 cellar: :any_skip_relocation, monterey:       "5f238c82b8e75848c5d04793e6a139931dd5c84c2b688431ad42f2707ca5d1a1"
    sha256 cellar: :any_skip_relocation, big_sur:        "62bade1946ca1a7a9459400756889522f5249589230c2ff8de13eacf3bfdfc39"
    sha256 cellar: :any_skip_relocation, catalina:       "936388bc5e2578f339432cd2dcc921306484377b4a1a9048e88b3250cfc89b44"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9ea67c2e4fc7c92cc8693aa458cc8f60f04c78c22cd09cfee59df15838e40725"
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
