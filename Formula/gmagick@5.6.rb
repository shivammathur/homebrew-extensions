# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gmagick Extension
class GmagickAT56 < AbstractPhpExtension
  init
  desc "Gmagick PHP extension"
  homepage "https://github.com/vitoc/gmagick"
  url "https://pecl.php.net/get/gmagick-1.1.7RC3.tgz"
  sha256 "1d2a35811a29e0744e852dda526f30c8a0cba516ef611758dd5bd4837ecba1fd"
  head "https://github.com/vitoc/gmagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gmagick/allreleases.xml"
    regex(/<v>(\d+\.\d+(?:\.\d+)?(?:RC\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "91ef08878b40286aee514cf2a5edd8f778ef7eac1533e0c01dfbd7638506f9d3"
    sha256 cellar: :any,                 arm64_sequoia: "3e506d57ef6ad5e1fd67c9189aca2f1e396869237334567af5559a6e221cab65"
    sha256 cellar: :any,                 arm64_sonoma:  "468554ec324b4eae100b26d0df52f14e9b4902a099da456b2591890fe1956f7d"
    sha256 cellar: :any,                 sonoma:        "3d16fed1048d359e06b53bd020fd364b964d10aa524faed892b8f8fb8c294c06"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3791bf0b842b8fc7f085b7dd22093d6f7339af2c8e638a9db4181c30463b6f67"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7c1026d9c7b66988c8d93b9672b65d7bf3076e90fe4941179c79bd099f1a0285"
  end

  conflicts_with "imagick@5.6",
because: "both provide PHP image processing extensions and should not be loaded together"

  depends_on "graphicsmagick"

  def install
    args = %W[
      --with-gmagick=#{Formula["graphicsmagick"].opt_prefix}
    ]
    Dir.chdir "gmagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
