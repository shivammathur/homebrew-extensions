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
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia:  "ac3777872c8bcca6d15de921218677673ed8923117cc5276983f4b8c7a984db2"
    sha256 cellar: :any,                 arm64_sonoma:   "3483d1740e5daf7dfcf0c260159a8b3d129d2ba14fef530f47cc5c93f30f0962"
    sha256 cellar: :any,                 arm64_ventura:  "a9dc66f757ccc64d5ba6339502fc854c21684cfcccfeb77231456a1f39b9abcc"
    sha256 cellar: :any,                 arm64_monterey: "c25591e87a466404d4392c111817b69f55de15674d8a88a71598ecd1a0b5ca44"
    sha256 cellar: :any,                 ventura:        "1ce14af8012a7f6cae57443b6f8f99a9fe89132eaa82a7a73d4d9c6b6b7ee3dd"
    sha256 cellar: :any,                 monterey:       "1ccd91e8b6ca0acd23c060b60f24d241c859f90010bd076ee9742185e3d78bf6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ecaf4607d1ebec162a491dd500c0fd635ef9f7e40f9a5219de794454632bd7d8"
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
