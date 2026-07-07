# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT73 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.1.tgz"
  sha256 "3a3587c0a524c17d0dad9673a160b90cd776e836838474e173b549ed864352ee"
  revision 2
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  conflicts_with "gmagick@7.3",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "29b91734ebb444925b74c230f3cd56abee6eb06fbb0dc67dca3122bd99090a40"
    sha256 cellar: :any, arm64_sequoia: "8086597ffccdcae731b4f5d7c080a74a4543d74e09665b21448c3f82a775713b"
    sha256 cellar: :any, arm64_sonoma:  "d6df684c1541265ae3c0d2a99ece1ff64cc6784370f3cf6f011c6d12241e8abd"
    sha256 cellar: :any, sonoma:        "3190b74ad2e51161b2a48b7a3b097d383c05223aaa8f546a8745978ca1efab09"
    sha256 cellar: :any, arm64_linux:   "508c5bdecfd0284bb12b3872230a3edeb758650bc388c2013f4c48c93ca53ff7"
    sha256 cellar: :any, x86_64_linux:  "1c1bd77bc5c4599c911c538525ffaf946c326ddb4432ca5e74e49b4c5efd2e4e"
  end

  depends_on "imagemagick"
  depends_on "libomp"

  def install
    args = %W[
      --with-imagick=#{Utils::Path.formula_opt_prefix("imagemagick")}
    ]
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
