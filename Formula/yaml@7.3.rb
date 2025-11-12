# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT73 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.3.0.tgz"
  sha256 "bc8404807a3a4dc896b310af21a7f8063aa238424ff77f27eb6ffa88b5874b8a"
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "5f3e930893c35045aef2396886e70795d60fd67402f59372608e13dc224fc10c"
    sha256 cellar: :any,                 arm64_sequoia: "fe1ac0df9641d30da9daf095cf9f7a0354f44f7bf8b8d445bcbe78c0ff44fbc1"
    sha256 cellar: :any,                 arm64_sonoma:  "e1a779a4da2e65d1cd8d7f316d0b53ae759f460fdb3026edab0daa3b3631c1e6"
    sha256 cellar: :any,                 sonoma:        "7a250927e1845808350b7bad520d681e13194381fa9025622a2d5cfcd12f0ec1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5f679cf8ca100d6a442afb31c4c1640cdfe6ff383f507335fc1360ed360d4c06"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4c4e2e0b8cbdf12f78f98f09f1fb70d0fd074c46a40251323b7010a66ed0bd80"
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
