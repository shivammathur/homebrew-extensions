# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT72 < AbstractPhp72Extension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-2.1.0.tgz"
  sha256 "7bba0653d90cd8f61816e13ac6c0f7102b4a16dc4c4e966095a121eeb4ae8271"
  head "https://github.com/m6w6/ext-propro.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "cae723db6806dac363d3ff01e578ce2e3e75aeea23818ac9c09efe410c3f9d43"
    sha256 cellar: :any_skip_relocation, big_sur:       "cc5527467bb437f1ad6a0bfb532e8d1eef68ab8b7145f32b97a5f08fd2323ef2"
    sha256 cellar: :any_skip_relocation, catalina:      "49148d2cfac65a0baf5e984732406b6f0bc608eac1fa611f6d65922e472293bb"
  end

  def install
    Dir.chdir "propro-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-propro"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
