# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT80 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia:  "614562557642fdd70e2bf374768693d81e85f779e68c0b7b5f9c7c2a89fd39cd"
    sha256 cellar: :any,                 arm64_ventura:  "36190cef9fee2758e3ce81d015fefd4207387d73b9f417c2f3d039709f5721a7"
    sha256 cellar: :any,                 arm64_monterey: "a2853f208b1b4c416208b60871fddd120138461151fc057a8066d68d5aadefbf"
    sha256 cellar: :any,                 arm64_big_sur:  "46c4a5f74a73eb09f5491d174beea2fbd43366552b02350e7e838bb748b2650e"
    sha256 cellar: :any,                 ventura:        "322a7e374e692f2b36e13019003c85da1076d5d275ab53ddcfeb163a35905b61"
    sha256 cellar: :any,                 monterey:       "6fc08328cd694f03b179003f5d706f0abd105c79ad00ce1c60af064d69ec7e1e"
    sha256 cellar: :any,                 big_sur:        "0ddeb8ac4cad89aa563b354eb265c8c8baf3e9bb7c025bcc4953dd99fa0de38e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "48bc482cc892e4696c76c81d28e90d026438e85f3f6b1fa699aaae5a645c39d3"
  end

  depends_on "imagemagick"

  def install
    args = %W[
      --with-imagick=#{Formula["imagemagick"].opt_prefix}
    ]
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
