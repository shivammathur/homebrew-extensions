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
    rebuild 7
    sha256 cellar: :any,                 arm64_monterey: "a4dff3dd0b852d93c11031e42a0a0dbed55dd51c44243de18a8ea7b39c666715"
    sha256 cellar: :any,                 arm64_big_sur:  "aefc4e015989cbb98c900fb07f84781c5a889fbb2c3f7a35391fb2e54b64e1a0"
    sha256 cellar: :any,                 ventura:        "05ae897fc5fb1bf92917f47b702e681b1074efd39ffa8ff7955c1f092544a34f"
    sha256 cellar: :any,                 monterey:       "930c86f5d675b3ab699b488f1d1692cff5edad30ef743a2d56f816f840aee966"
    sha256 cellar: :any,                 big_sur:        "f06983773c8212ab042f2e5fec3db47217d6e8ed1dcbf75ee0953c37be4c5b89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e011a6c65cd1aea80abd8a74a5e5e30994c78cbee29f8c20dea76ee30c435fe5"
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
