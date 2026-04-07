# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT85 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.2.1.tgz"
  sha256 "b9f826c90c87e6abd74cc3a73132c025c03e4bd2ae4360c4edc822ff651d694d"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "aa4c0bb4e9ff612c75921b05f45696f49991a644e34873bf42ff609a1e180e93"
    sha256 cellar: :any,                 arm64_sequoia: "decb1387a9a360e2a12caf90802ad8ca93e4f325475a05903108766588db27e8"
    sha256 cellar: :any,                 arm64_sonoma:  "80f3010f1e45faa947ec455022b38303c527af74cee18ae80489c7b8ccfe967c"
    sha256 cellar: :any,                 sonoma:        "d87814e5c60c05ac7a85e2a8ea55d322343a71efff28592210887f97889b66e9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d530a8a2ed05628a69d9dff741fdfbec14d7e0cb266d627f2d40d215baa7ba3b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "94e2884df0142d921634817a6e97c8096ec8bdf1e9a5257835c019c789e30b2c"
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
