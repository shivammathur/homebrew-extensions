# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT71 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "4365f8aada6b9e9939a1dedbd77a95c91ec965dda298fabe3fb741f70e2673cf"
    sha256 cellar: :any,                 arm64_big_sur:  "9d8f07998a0035263a2f2c73f7161bb480ba2ef014ee666b01fac7950f1e0875"
    sha256 cellar: :any,                 ventura:        "06bd3e869139f5727a41bbe037366830d9c92e6320ee84622cbd22c254423693"
    sha256 cellar: :any,                 monterey:       "57e013c7b3e55360f2f9addf25e7229cfbc5d695d18e54ccd33b9e59eb8d5f47"
    sha256 cellar: :any,                 big_sur:        "b5be9d924216cdb31784486539fa26689fc2386146090ac9d12b04462a5957d4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7233b4ebd4e8eac7b86b0a5e961f118073c891aba02c0c88bd8a63409844c817"
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
