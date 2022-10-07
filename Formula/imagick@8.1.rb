# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT81 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "d96a102a3f8e46b8fd1185c25038179d7c578fbdbdd507e4401c690f729dbbdc"
    sha256 cellar: :any,                 arm64_big_sur:  "9c41ae9766139bb4a6fd8de679a5d9caee3b5035ac47d775fcc0d4dbe92ca92a"
    sha256 cellar: :any,                 monterey:       "bc2a486477beb8afdebc7df60707b839d55b7d6c645e2f96af413763b0117bfe"
    sha256 cellar: :any,                 big_sur:        "ed7a87526f237662601ccd8a7b310b734f7feab58bcd301f77bc9c902a1ac1b5"
    sha256 cellar: :any,                 catalina:       "d8538545e555066bc232c3b020d7817311e953095f585fd2a2412af4ec9bfd9d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a388d6473d58259ea5815113aa0c4431e61e231a99e013ffe43a8e21a4415d43"
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
