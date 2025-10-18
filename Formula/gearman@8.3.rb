# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT83 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "136f87a8e2b4939e042bfbdec1ef34090d2c9236b1388d81a1c67a72b1412453"
    sha256 cellar: :any,                 arm64_sonoma:  "0aadd2eca4c43bf638c0cbb172a161e3a3af945b008b689c85cacd067aa8885a"
    sha256 cellar: :any,                 arm64_ventura: "ff3b10614cad409a6d6905ff114d95a4ecea060d38a84ffcca1d9225d2e29cd2"
    sha256 cellar: :any,                 ventura:       "5d8d6677a0ad86575a346e0c621c8055ef685e4ae0349077e23a04117d0c4a63"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a0ab6896e61701812d2d05d211b54fafb93f6ad4d7a3002e5693c50a083a2b12"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "82ebbc862d7fdcaeb24af209c78c81cf5ee3f533bd10ff93902e25b329024f09"
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
