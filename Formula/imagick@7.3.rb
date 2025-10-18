# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "7397d0fc84fc1082c07486e3fe399642d156d18e4839f948729349e84b133e28"
    sha256 cellar: :any,                 arm64_sonoma:  "d62c176605f17d966a7b47e9f51a4c257509711edfc0cbac335a7eef69dab0b1"
    sha256 cellar: :any,                 arm64_ventura: "aef8ade3d3d1288051a96fe47ed41dab82014b81ed024717caa623d8149cfaac"
    sha256 cellar: :any,                 ventura:       "a8a80ac7735e27e6fef8b4903a9bbae9958bbccc45d90f96f363b9d48edf677d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1c1074e2249866c37a58c7e24f023eecdc839655c7d6f860d55888d7aafbe4a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5cdbb8ef8d5ae9f312b9d51f9279bac959e634b6b104b267bb37c86a86216a17"
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
