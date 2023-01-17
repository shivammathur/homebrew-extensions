# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT83 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "8cee308038df3e15ff59402961c14c76f5a231853b4466d0627876e1aedcf0b1"
    sha256 cellar: :any,                 arm64_big_sur:  "0eebd238937422222879ac0a7f9bd2ffe18e19bea0c06d45409be0c4a799feba"
    sha256 cellar: :any,                 monterey:       "7ddcacfe4eb17b7ae3f1f87c826286f1d3ddd7d1549107e377c72be85e2e1d12"
    sha256 cellar: :any,                 big_sur:        "0b484f9f44235e131fcf62c06d6d899ca85fcbd0b57d87fe0740709437207574"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1295480e570d6b4937dfdf132a5f1576b451b4237a051cad022ada14577931b4"
  end

  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
