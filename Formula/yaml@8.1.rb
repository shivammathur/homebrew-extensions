# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT81 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.5.tgz"
  sha256 "0c751b489749fbf02071d5b0c6bfeb26c4b863c668ef89711ecf9507391bdf71"
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "7f7b663b3c63927952eb207f07c28708559314bef0fe52d101095589275c28ea"
    sha256 cellar: :any,                 arm64_sonoma:  "63fb40b87d3fd09fea75ce516041dbc7f3c79fd8b0d0f00b251496df0c234413"
    sha256 cellar: :any,                 arm64_ventura: "21326f45cbe95b8d0837b27b3973f5969a268e33b1c19f81eaa433f5564302b4"
    sha256 cellar: :any,                 ventura:       "284396dde8989f4f15e5e3606b73877f0440eac59d6be03b590431de287fb4ad"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9777e613edeaf89518f6b91fc61a9e80760971d4af87b8b89b6f7cc7397ecec1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "05fbd05de8cbf20016a5599458fa031ca48ee91d78ee9b2d10eb1928cdbb75ba"
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
