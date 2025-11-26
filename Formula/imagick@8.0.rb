# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT80 < AbstractPhpExtension
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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "f716a4a8197bcfcddcfc5f6ba7d56b40f3c3e4e79673b10bc6d7140bb79d1c80"
    sha256 cellar: :any,                 arm64_sequoia: "248a038cf2950176f4d4e8849a61d32866722c0e1acada10268591a6c81cb124"
    sha256 cellar: :any,                 arm64_sonoma:  "6616c5a3f3a5b78931f531de9f38bc5f30c4f0cd271cf4a713cd0fbbedd031e1"
    sha256 cellar: :any,                 sonoma:        "a25154f89250cda5311f8269ee412abb40543e7e595df87e607e596572b9f330"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "55cc2115cc945768e42f07b023a36b49d6bbf0c912ee4864508769ec763d7d65"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "49fdc727497b5dcf53d0cb1950bed43b1aef90f87003f505200d617a62b6ca4a"
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
