# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT56 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.1.tgz"
  sha256 "3a3587c0a524c17d0dad9673a160b90cd776e836838474e173b549ed864352ee"
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  conflicts_with "gmagick@5.6",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "13409cf3818f6eb5d7359f5b987d76602cb6fe213bd4c0fd566bdaacfcbb46b4"
    sha256 cellar: :any,                 arm64_sequoia: "520ed583039051f5fba4e9799bfd58f049ccafea57225aa197c80b5435b8ce2b"
    sha256 cellar: :any,                 arm64_sonoma:  "8d8b38e4a80c5cb7c1bd211e0f1f9547337472e892cf0874d437996c7dacec10"
    sha256 cellar: :any,                 sonoma:        "46164be8cf545885aecd1b15762d96f7c349c69bf1dd4d274b2a386de9d1ac30"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2916cc48196daaf43fe47ae129101a2ca5edd6e25c88e2db1897a29feb9b9d20"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1abedd0465e8079a03cf9a6ac6c6962cf3837e130cf100b752c3166c82a0c3de"
  end

  depends_on "imagemagick"
  depends_on "libomp"

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
