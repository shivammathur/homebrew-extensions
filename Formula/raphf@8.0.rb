# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT80 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "6d5a04ccbe96274e2db168e8d45cca8c40fb623fa2804758fc1dc4ca7d887f57"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b60d847c27e0f127277bd87f84f72fec8be2ebcdb5301f71205b13fa0da8fd50"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b90cc537f3a1751291d80e5440bef3f334227d8706986fa1e9c475e0560eadf9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5bf6264d3fdb3aedf906efa1db7f7e594709ef4f166a86155d02b3996d1ccdbf"
    sha256 cellar: :any_skip_relocation, ventura:        "8d58334ce122011719033f68df76e9a7e236d14f914cd27839e2fac20d729228"
    sha256 cellar: :any_skip_relocation, monterey:       "c17ff17426c99be6d3fcc2aa35f1cf6324665bb55020e600975c55482e946c38"
    sha256 cellar: :any_skip_relocation, big_sur:        "738c2bb4c7e44c0c457e92be1a639e8633e5a57df1f6226dfc0b4558f079616d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3bda5a0dba9ab4aef3e7da028d815c40a8f39587f8b70bee37931d21e2514b76"
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
