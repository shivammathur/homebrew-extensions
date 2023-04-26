# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT82 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.0.tgz"
  sha256 "77075fc250fac2d3878deb255d44efc3ad76cf7b2c7f1af420cb17839a03c0bc"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "e90df88d696e89994fc0ffae1ca94f23c858a7851ef4da7cfba2d1f919a18016"
    sha256 cellar: :any,                 arm64_big_sur:  "19bbb1b639092b9b4e2034ab9047b62fe2c65795f527d0a6fefc0c549c2538a7"
    sha256 cellar: :any,                 ventura:        "192f0afe2e8e6bf13fa49d68833ad9a886078d402b96711cef1e669399a40827"
    sha256 cellar: :any,                 monterey:       "a045e78eea954d5f25e55d74907abe0ca176dc39142bbd2f31afc312a80c0db2"
    sha256 cellar: :any,                 big_sur:        "2401446cdab52cba1981f5b300c771c78d48563ffbc9e743b5101e2a6da938db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f31064f3644eddc44bff6894a09b02ed1cac9faff9a343117635a5a0b834ce7b"
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
