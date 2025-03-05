# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT85 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "5d791bb2ec83ac3388e62ca1d0a006655d4f51b38e0616d4f31ea85eb8e14d1e"
    sha256 cellar: :any,                 arm64_sonoma:  "cf8b26d1673e34ecd8d169518bc366d405051cb67d58c9c66754a6c3ec522cce"
    sha256 cellar: :any,                 arm64_ventura: "cccdddb43785f285b5667d4436ad1f89ac0498c20826eef8a09b5068d37092b8"
    sha256 cellar: :any,                 ventura:       "a77f2f3db6b3b6a79f6039162c2a6fbbb03a635c4cbf0b74193d432a53d9ca94"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2ad22a295c501997a215155b335282f2ed3623d5a9f96c49d7578a46bb6d1ee0"
  end

  depends_on "imagemagick"

  def install
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
