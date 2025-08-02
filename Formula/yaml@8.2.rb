# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT82 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.5.tgz"
  sha256 "0c751b489749fbf02071d5b0c6bfeb26c4b863c668ef89711ecf9507391bdf71"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "4d5bbd8797e218f99cf2cbee4d9deb20c99c16a6085a9d6a1680f1a7b5390f58"
    sha256 cellar: :any,                 arm64_sonoma:  "2d049ee65258c914802002f6d4b4bf75d613abd634509687cd98a9b0853fa221"
    sha256 cellar: :any,                 arm64_ventura: "6c4860fcec3d6d4d28ec6153fcb0ca9ab3a527bee1721afb8232053d86cea9ae"
    sha256 cellar: :any,                 ventura:       "e2ba05970b5baa4f941b4d118865abd0d1fefc20735cf4df59b924cb02808c46"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5fe02a59d19f052f617bf0bde2e8c047e27ca109b6bb44ea1185edfcc53db5b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0b6b99cf30aa4054a4903da5f0d7ed9d0615607c8b8c7f5beabeeb438600ac67"
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
