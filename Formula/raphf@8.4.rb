# typed: true
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
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "144137c02be4ea267302f24ea8e584223d7ef25d91c4b11c7e521963a5ffe8d9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2cb845a81f3d90547f19233032f29525282056dc2e2897a596ed94a6b35bf99a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9d02724176657b1ca998fa5b24d5553db66f989b43cdc5ba7ca5b2d052d45abc"
    sha256 cellar: :any_skip_relocation, ventura:        "aa0141d99b6d06d155699dc58e497c6a26a1330cb4dacfcf794461a36dbdeb2c"
    sha256 cellar: :any_skip_relocation, monterey:       "e88ea9089adf8e458bb3d368c45e1d8ae75b5fde73adcf7b717b19310ed80f56"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2a0b6323fe8b17c1e076d20099cde61cb77a46d47a2baf1bea31b1e6761c13b9"
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
