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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "c87530a9026bfe6eb7374fa80ee433b3f6b28b8dd89e469d04f9c934eec35e3c"
    sha256 cellar: :any,                 arm64_big_sur:  "1dd72acff34971eed76ac53b0426485f211f1c441d5174837e4b0b054dd01721"
    sha256 cellar: :any,                 monterey:       "ecb81b6979bc5087386b9212e656e902e1930a286edc0adc6eefa271486f5cd4"
    sha256 cellar: :any,                 big_sur:        "ca35c1ac5478bda6428b16bbc7962c7e5b0156a89388845f186ac6e7e598c721"
    sha256 cellar: :any,                 catalina:       "919185803bfde8146cc4bffe18343ed1c077b5eb9b6b5864921a71ab115e24ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e166710e9d70528df5885aae6e72ae2df628e97ce29aa4a9595605dc9ec70532"
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
