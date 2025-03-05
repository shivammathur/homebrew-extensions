# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT83 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.4.tgz"
  sha256 "8eb353baf87f15b1b62ac6eb71c8b589685958a1fe8b0e3d22ac59560d0e8913"
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "b28503b975d01a749a68b3177d4d20152bb3e7337fad96f54ee3df0f26cb57d7"
    sha256 cellar: :any,                 arm64_sonoma:  "22ee3b6cecc5d63a7b87f9e86b655260bdb9d9ac7fa8dd89eba91c7aee0f9765"
    sha256 cellar: :any,                 arm64_ventura: "2e03021de6cb6806477c9436a9de33bccff788677b7dcb2255dcbc5dae1b76ce"
    sha256 cellar: :any,                 ventura:       "0e08e47bd967f5170fa810e04f871bc381d231e16faefc4992f97eca5375adee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bb51d229a7a7eba6bd79be64fefc2d135b1e155aeb3057520a63c3ddb066059b"
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
