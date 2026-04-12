# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT83 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-2.0.0.tgz"
  sha256 "52dfed624fbca90ad9e426f7f91a0929db3575a1b8ff6ea0cf2606b7edbc3940"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d7b7fca0bb7c48ddd58285c64c07c6a37b24d3cd31134b7680788b8515a286a0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a4cbe5ae1c28a584291a9a13fa2871d9ef4c346ed02ecaa2fe8a63b5c015d022"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9231db1a012f34ae6f288cf2e33e45e0443d26cce44aea388456de198daf4279"
    sha256 cellar: :any_skip_relocation, sonoma:        "6f1f819ac8227999f02c05a69b1672b5e10bf4cfeb19f1fabaed70ff9d45f83c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "75f54c4fa425e9d8e63883ef1de105de60033322ac85564b11a5b2aa5cb9d02e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9cd4962d8bc55470b440360d356cc2ae3df1ae84aa528837be97271423cd12af"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
