# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "c73dfe799e1364ccb6dbcf03a6896b074d771cd22c47ad46a53841cf76f4c3ad"
    sha256 cellar: :any,                 arm64_sonoma:  "207096e40692e495943380c4f1be44c2dea7dbe49c7df2cd65c4f74f14b7adda"
    sha256 cellar: :any,                 arm64_ventura: "09644671000207b74761199c0e9503c19b5655442824d1491dc0733ec28059c8"
    sha256 cellar: :any,                 ventura:       "2346c5c100e452ab116b8a143afc149dfd7d75c6a11774f032d4b88d7a5599d0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1c305f2ecd6f2ec33baab4919da8cf40599a891514e8cebe0c29857f777ba74d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e124476408ec35094d89ca2e4bfa3910b9d220002aabd9d97dd3fcaf4265c370"
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
