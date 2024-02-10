# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT84 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.3.tgz"
  sha256 "5937eb9722ddf6d64626799cfa024598ff2452ea157992e4e67331a253f90236"
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "2190d82dbe9023ca49cec751351f64114b02abef424769391a5e3ce560177a9b"
    sha256 cellar: :any,                 arm64_ventura:  "339d9b150fa37c9a8e46a55e31bd25c5e4413e8a7d2ca891593a213efbca682a"
    sha256 cellar: :any,                 arm64_monterey: "c16afc311451743b39cc1050041426bc6155f80ce891d06d19614eb228ded28e"
    sha256 cellar: :any,                 ventura:        "d3b2635d8185e6d13ebf7c6d77d562544bfb090f3fae7fdf5a455d5c19d2e1dd"
    sha256 cellar: :any,                 monterey:       "e861fc50c9e66e20c5ffd3f2d574f8d46b5a5c2b69630f15dbcfd7e37ef4db1a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "374f4b80f0be6fa1d2999d9f9dfd12cac082652ba3318d19d621f4feb89fb0b3"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
    ]
    Dir.chdir "yaml-#{version}"
    inreplace "detect.c", "ZEND_ATOL(*lval, buf)", "*lval = ZEND_ATOL(buf)"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
