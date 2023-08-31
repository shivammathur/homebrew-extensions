# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT83 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.0.tgz"
  sha256 "77075fc250fac2d3878deb255d44efc3ad76cf7b2c7f1af420cb17839a03c0bc"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_monterey: "b28d0ade42b85b9f41369828c497d2168a5e5f38c83dc783ac12202245ebec76"
    sha256 cellar: :any,                 arm64_big_sur:  "b83c11a59f8ea022c5e023e7fe56d20acb05be35804dab7e4ea053f3e0f87641"
    sha256 cellar: :any,                 ventura:        "a1b22e6669f71d14969bb6bfca3d7fe8ce1123d4a93033f44cf1ad8a6c9762e9"
    sha256 cellar: :any,                 monterey:       "e7e1a661f198e545999e6361aae1b733db0b470b743d0ecb87b92f9885ffc160"
    sha256 cellar: :any,                 big_sur:        "fda12f70eb746d5cb8403e76a04f1bafbad32d36ff85b0636688066fc995ea71"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "054011462b1ab648aac24c9d41f88b22c407c4e90bf96cee937afad24f2a5bbe"
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
