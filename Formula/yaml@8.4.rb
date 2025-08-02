# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "68bdb2fc92587e753739e4eeb8e093589081fee6e677487e386dfb17969b73ef"
    sha256 cellar: :any,                 arm64_sonoma:  "32fa284df5b93c0060bb4cd5d3195d9c8dc6002cd8d9db7fa2973f1a59c72368"
    sha256 cellar: :any,                 arm64_ventura: "855b928ee5f9c404106e4f56ac96ef4a9c92dab6a25ddd29455526d5cae45c61"
    sha256 cellar: :any,                 ventura:       "9ca62c4b948de7c1417bacbd16f180e26ae78ced8607adcc7075b4fc4186bdf9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b3a39b74205aa2d718c13b8678dfc5fc20d879e2c11cf63b2820c293f5d57dba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8a022102458b20d65c523cf699fd39b49b81193f73bad36a94089387b0d369b3"
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
