# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "f3b7d4e8aff77bbb74b1badba6418fa6c68c5c2584fe438864c7f80fb90ab3f0"
    sha256 cellar: :any,                 arm64_sonoma:  "16b4301d960a1c0bf1465e5aabb05343fcc79d6a14da369fbe565d4742cee56e"
    sha256 cellar: :any,                 arm64_ventura: "d762f1254af261c7214f3382e00ec5585d54156ee1878812aed48406a9051e7a"
    sha256 cellar: :any,                 ventura:       "5fe7e2b476a275bc4212748bf8d47816f89a8a5554b16a624d1252423bd99494"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2730128a3ccc0fb54e029d5159a5b982a5c9715d197c3be16d1a393b962d89d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d64396151489ef714f1020f4f6566e20e7fa357dbc86b4249f9ab70d88f765e6"
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
