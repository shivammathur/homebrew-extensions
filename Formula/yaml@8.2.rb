# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "801d38866707b57a40acdf9a0427afed0633dd48e9a2f1d554d689598a3a87bc"
    sha256 cellar: :any,                 arm64_sequoia: "fe55f853cdcc8af9c05879357599448f28894a9f6ba8ffa004103d6d11a0f22b"
    sha256 cellar: :any,                 arm64_sonoma:  "f395fd74d2ccc4774d21c131f118656870be15967f4955d3cbbbe2f3f3269acb"
    sha256 cellar: :any,                 sonoma:        "c4b451a564bab9c440411e361141c4ec10f2e83ae263953fdc1f4400f7955882"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2ae51c07557d7c1258c9f412a03da8c10aa2ddf7a1ea85d0d22e0c965f2f1a97"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d3315afe4e4316c3332d3dffa0f3fcc1a85bd0177742d45e5960f5368c0651de"
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
