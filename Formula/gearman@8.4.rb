# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT84 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.2.0.tgz"
  sha256 "2d2a62007b7391b7c9464c0247f2e8e1a431ad1718f9bb316cf4343423faaae9"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "469361c003869a7aaa3319691280a097fc5f008d6ab3f8af273e2738593d36ce"
    sha256 cellar: :any,                 arm64_sequoia: "859f15b00efd8e8df80130707dcae7878502e09efb3bfe1030a272a1aef4dda9"
    sha256 cellar: :any,                 arm64_sonoma:  "b28e3219f5ba494b0c1a826bf0c7f7fec4742fdb2b77db6f2fdaaf7910ec335d"
    sha256 cellar: :any,                 sonoma:        "0143136b423692fc8b986cefae0f75a5b662ed2789af2c049ad4176c8c817b68"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "59a6fcda1899b1fc3d1987ce52301a34b2079e212c9b9573ffd2edcebd069961"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ef5264d2de8f32fbb0ac94712e2d1de8936648ee12628f43bb4b5d8341ba1599"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
