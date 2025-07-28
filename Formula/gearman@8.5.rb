# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT85 < AbstractPhpExtension
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
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "cc1fbbcc64d9f332b78b09ca1f8037ce0a2c2e56b46456ddfb34769061c691c8"
    sha256 cellar: :any,                 arm64_sonoma:  "43ab16aee5ac6b316d83208ad35f5794b4988588869272a19feab25444124898"
    sha256 cellar: :any,                 arm64_ventura: "32fa40146444bad1d9ed2c9330597d2b24984a8f1380e63aa773f62d53f41b0e"
    sha256 cellar: :any,                 ventura:       "cec49ec1056075565bafed090f14f90bd369f19e29c1b2b30031689bc47696bb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "797c831f9b9639ea81261e4c5c33a23d6455dea09d958db3d8855370663d02c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8a68436ea0ab165d0cb4298d7e61357d64f6d58f6cae82af1fb08e56260053f2"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    inreplace "php_gearman.c", "zend_exception_get_default()", "zend_ce_exception"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
