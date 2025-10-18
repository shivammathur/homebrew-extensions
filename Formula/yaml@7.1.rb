# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "542f328faf0131cc92e6c21071b8755b2aea55975049505e6ddfa39cfd8d4280"
    sha256 cellar: :any,                 arm64_sonoma:  "21e7c590015d472c0a6c57f524e98a8187a72d5d8a95ebb21a83933341d7fa70"
    sha256 cellar: :any,                 arm64_ventura: "342a042910956ec9ea5bbcac13e2489772ee04f393cbfbb490b9d53fc37544d8"
    sha256 cellar: :any,                 ventura:       "a72de318569e9f1fefb5845cfd36c6798e458759322a0a0bfddeb0186884bc55"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f85b392523ff999d245cdaafcb49bcee28870c97f005b2164e225a6fd0531fc8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8249aff6cbe93afdf0769ff6dff84788ab3407f354ea315f23e0fad878428134"
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
