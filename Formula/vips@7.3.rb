# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT73 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  revision 1
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "4a02333f83b0c6aef623d8bbd1fbad70e6307409349b2461ea79cc2623b0b84f"
    sha256 cellar: :any,                 arm64_sequoia: "621b60c44912d9ee6795205facc0416f8548b15e8696222d1f4958107b0f0816"
    sha256 cellar: :any,                 arm64_sonoma:  "028d1bf3dfe379bb2a2be621f2ed766480798cb53630c00a84fbb0405847074f"
    sha256 cellar: :any,                 sonoma:        "0933e9932f5cbb99e042e212f6e49a7678455309e00e6d7896acfb342c048705"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ad99758852d6c2d42a61f77639df83a2bcfce302f94ca8aae40acb7d91f1b076"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "157bcec1bbeea8ed61776d8e90db9f5cbe141f4263bd41b8bb3bf543316cd520"
  end

  depends_on "gettext"
  depends_on "glib"
  depends_on "vips"

  def install
    args = %W[
      --with-vips=#{Formula["vips"].opt_prefix}
    ]
    Dir.chdir "vips-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
