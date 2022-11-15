# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT81 < AbstractPhpExtension
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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8b35713dd47fcf7fef50f9e33e67d4e38ef62e593bb2e29157994d6c16de1b2b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b3a0c73ffc70c6af5d992c76ef4453c1e2275efb0a98a0bb1f0a88489cd9127f"
    sha256 cellar: :any_skip_relocation, monterey:       "26972bd3b7713447d7911e78ec11a6449ed8670d85f36901caa16e26199cdc64"
    sha256 cellar: :any_skip_relocation, big_sur:        "b345122c2ff0c6376dde10aaf89fff957f8c9fa6851d84a3948621ada774ff4b"
    sha256 cellar: :any_skip_relocation, catalina:       "255a275edae78b59aa4e022936beadf46c5c9c1a3fb9bab388f6bd9e805b4da7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6c6712fd6b530781b1494c19504a0a677ff9a5df95c68f4d27d69d50210debab"
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
