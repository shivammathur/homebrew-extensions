# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "d99daf23b5314abf364a7b90cda5b15169906d174170e7c6b9be90d75d7af223"
    sha256 cellar: :any,                 arm64_sonoma:  "7cfc354612ea7d15f353c569c9d1b6e40204a02ce7d34a6c915260933fb57a4a"
    sha256 cellar: :any,                 arm64_ventura: "e5e5376cc52f3270346b2db7d4c89bce30d9914baa42987f35f1c8cf8e3cbb45"
    sha256 cellar: :any,                 ventura:       "7d604d09cefc0709b8ac27870b0a68c32d145541bdad79226305fc9f942af108"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "aefb8e0b10c59b9f45b38f28efc729f5e3dde5165f3ea4f58b536f734b0db700"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "839e2b8ceb353a18af4fa659ae3542e51c2b1eece64b65c63809d89c459d20ef"
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
