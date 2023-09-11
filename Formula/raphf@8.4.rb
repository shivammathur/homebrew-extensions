# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT84 < AbstractPhpExtension
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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "848c1d8a7be850ddfa9b53a2b4432bd2aba412ec1610bca636c171e7e4da6898"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5d60ec7d5bc3a63405feb977010403136c4a705814053f3cb45f727dd63fe9c8"
    sha256 cellar: :any_skip_relocation, ventura:        "05a708c51c7e386ffb2316f12028f66f697cb14d70c90ff2b2388e118f945578"
    sha256 cellar: :any_skip_relocation, monterey:       "03a09b6f2c5362cb037916cbca5da1e481cc1d1b7d08bc2f45e7cd64ec84459e"
    sha256 cellar: :any_skip_relocation, big_sur:        "73ad01ac3673bbc3c84f920b741db746fe03e762981574fe5ece24ecbd128006"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1879424dbb1f45d219ae58791a2ad41366dacf280d7c6cc1dfe8063a65f0563d"
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
