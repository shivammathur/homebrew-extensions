# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT84 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.0.tgz"
  sha256 "77075fc250fac2d3878deb255d44efc3ad76cf7b2c7f1af420cb17839a03c0bc"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "379849c77472e1753f74cf4bd02725cfd1ec50ba463c14553a5a55ce455a599f"
    sha256 cellar: :any,                 arm64_monterey: "73eaa6aa7c470a061aeef15688e76125e995b78c8f092b599dcfa3fb4ddab42b"
    sha256 cellar: :any,                 arm64_big_sur:  "83001b25de3da9a0c10b1f60ef5e071a6ffb51e538453e5793822e18141f712f"
    sha256 cellar: :any,                 ventura:        "5e435ef49210459fe97b102a35197786f658f9de994d30620ca537af62465336"
    sha256 cellar: :any,                 monterey:       "19aeac6dbd7db0b9566587b2dc4b9697e40ce2c1a1d685289cf2169e2dbc38f5"
    sha256 cellar: :any,                 big_sur:        "a87078076db34f91203dc662eae8df0a97ebbbfa9c2f32e4863136aac29c8359"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d77f87cc79058d6472d17a878469343fe5ab929b138eb5031ac93e8146f82a34"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    inreplace "php_gearman_worker.c", "ZVAL_NEW_ARR", "array_init"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
