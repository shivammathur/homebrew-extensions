# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT70 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.0.tgz"
  sha256 "bda67461c854f20d6105782b769c524fc37388b75d4481d951644d2167ffeec6"
  revision 1
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "f826f20bd3f58d5b430dd802ab9476ac096a2a73416824247f560da459eb987c"
    sha256 cellar: :any,                 arm64_sonoma:  "dc06821979d30ce17c083219623aef5457d7b5d3f38e97132dce8b12a53a3374"
    sha256 cellar: :any,                 arm64_ventura: "35744f3b09bf392728b424ad1a41457194e06ffd60e0de52876a0543e37bfde8"
    sha256 cellar: :any,                 sonoma:        "945bf7c6e31fb4ae8a257d153940efc9b1ffc550feab114fbb2ee83afaac3223"
    sha256 cellar: :any,                 ventura:       "863ab398ffb7804101cd2d05a9d1b345a2fbfa23c79ead681090f329cbe90afd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f0dc538049869eb21ada8c88cf4548c288571db4193de607c4e4cd9e20999bf0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ad9a3eb22a3c1e2e6ef611f87f0ed0718c9c1ef071b4b06aeb6a39ad38472858"
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
