# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.20.3.tgz"
  sha256 "629c33700b591b633c13e851ffae8124758df658154e3bed828c828250508e00"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d8425f9adb12c8341eb1b75531c97917abc53c4f63af34ebfb26550943b57a4e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "eb8607607b3c78e1b6e54003c5d872c5678f0f4d50be67787a83675eaf5bccc7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "365efa11fd38cd4847f5d33aa2376148dfef40cfa3d2bdefb5311e656f4d0f8c"
    sha256 cellar: :any_skip_relocation, sonoma:        "705815bd4571c38fd97f810d9d2339e544d1ff5a81dd6f810b5fbd332033fbec"
    sha256 cellar: :any,                 arm64_linux:   "6336104491f71f83c1f0d00cb4f1ed8e947f9f19868a06ef179659fabf7c7029"
    sha256 cellar: :any,                 x86_64_linux:  "032b062eb40da215a3227020efec8177c6d2926e662f572e7808aede8a03d9a9"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
