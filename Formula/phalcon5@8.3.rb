# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.19.0.tgz"
  sha256 "7586904d16a799a70bbc2cf6284c6ff45bdbfe10bd016c5971a20e3d943a8d15"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9f6f91040729fbac479a292186fad68c9de1af03db85a6a1e4a61c12a63534bc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d26392b91e7ae00e1f6b2695f69435e2b4a33afcc68da571645770e2f90eae54"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7004267946cc7e4797044c1e153f948fefe0d6fc09280c8bb48947bdaaae922d"
    sha256 cellar: :any_skip_relocation, sonoma:        "f24b4bd95368893ba863582e9442690713003e73bdf7e957bbd5f7c23af2d097"
    sha256 cellar: :any,                 arm64_linux:   "0e0415d09c0a0fd56573634daf110fd07f8556bafd161fcaf2fdf70334a71b75"
    sha256 cellar: :any,                 x86_64_linux:  "6fa6ae55822f33584e5586a16b87470c6d881dde52c6ef2498aeaf2bf8fec630"
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
