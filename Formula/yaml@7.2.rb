# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "c13d6b18a7a9350dbaf00316a5b98db67ea4f90edb50ec47c549e7f16321756e"
    sha256 cellar: :any,                 arm64_sonoma:  "b46b14701135ff5ca29aeeba6f264cc6fab94e561b0959acb96a2d7e70e6d8cd"
    sha256 cellar: :any,                 arm64_ventura: "edab88c0dadfc27b65bcbd9a3dd7bfecf2307283ca905e88ec0828ed5d34cb30"
    sha256 cellar: :any,                 ventura:       "f40fa71a7d53c9ceea09d327cf69bdc505d714cf3647f259350922b067ea2b86"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f0cb18b0f228d00ce8d6b0ca50b1fb79e0104f8befe1f387d44e5c7fb70f77af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5fa0b3beb1a2ad333fa4663f81d4c05d6d0125855953b144957ac2cb419bca69"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
    ]
    Dir.chdir "yaml-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
