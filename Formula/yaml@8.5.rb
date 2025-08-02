# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "4649a6a95b9c74057591d99a252a81b7a1675fb69a1ddd70b4bfd0e5a7c81288"
    sha256 cellar: :any,                 arm64_sonoma:  "1a1a5cffd843e84cca0bc9808d956806eea9a07976245e957852508d5029c5e6"
    sha256 cellar: :any,                 arm64_ventura: "9f965661d944fa0af014b514ed31e8dd6ddbb776f0d86f4e6b9fd58f52c958ab"
    sha256 cellar: :any,                 ventura:       "3ce57c83a8efd6573d102a1463d4e191e25eb1a5f8fbbe1e5dca6fe2c596eefc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0a3226cb6c19c1ce1b75b38aba2da303bea8a9cbd3b63ae48909cec52c02a420"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c0ee0ba6de9d3e9bb110963d9def8fe7e0d279362d48603974200ba3480d4822"
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
