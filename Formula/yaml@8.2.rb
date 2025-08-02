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
    sha256 cellar: :any,                 arm64_sequoia: "1b8ec1d1f2a5aa4bc7ea49f6b23f7d0b61f5efc9b23422523af6c39fd48e9a03"
    sha256 cellar: :any,                 arm64_sonoma:  "bcf8660d757da70d9d66f5971bfafecfd4860e635bd792218bbbb7be86a061ff"
    sha256 cellar: :any,                 arm64_ventura: "bdeb52ec36358288f0152be5e6e651e1bcfe9ced15e71822049c06fedc190ebf"
    sha256 cellar: :any,                 ventura:       "6db4afbff10b4a80cbd24b8b53603b15d66e9c969205980a80a811283e3fe2c5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "036df2e43d66677e42f5d3dc5e935b9b720266b96fcf516e934802e0e58ddef3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c6424e1c1e68514d3a1c8c08a47922315c54eb97b4d8991384c99d46373210c9"
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
