# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "5796c5adba9ef2fdd9594798d386d36e3c4441cdd8a431a43c6e6aa2a0bda120"
    sha256 cellar: :any,                 arm64_sequoia: "9a1f11df0522875dc96b2a6bf082f15a54384eaf98733a0f52257439c43de3d4"
    sha256 cellar: :any,                 arm64_sonoma:  "79187a03211d864c04da8f2620128bf2eb687796f03575aa8d2f61610d5bdd02"
    sha256 cellar: :any,                 sonoma:        "b0d5b6a455a83bed5b8430cc0b2b1c24f4ad8f002da01913b2861b946d53dbbf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a62c985fa1175a90347d74716b8442120046ed62dad007a3f866ce7cdfd1361c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7ad6a4b1148dc1850cad6eb22931d59bf1003997e0818f29170ff7bd1c98c007"
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
