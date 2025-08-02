# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "f0a089f25157ce68706ec3f562618613aadb94a3cd16b1e490d34c4decc519e5"
    sha256 cellar: :any,                 arm64_sonoma:  "2c351462ce58a8d10c02aeec9bb9101d2f3d726c469679907d622b471e58f70b"
    sha256 cellar: :any,                 arm64_ventura: "273134752feab44ef7128b9373dc9acfa35a586fafc7e9f198449fb88b9d9208"
    sha256 cellar: :any,                 ventura:       "96f15fa3cf897ae294ccea8ec41b707aec5364b2b6497c18ed50dabe1a42d221"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "353c18a5628d306bd2d7ae0f22bfc389d82eb18a48869ad62ef8750c8f2afca6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ff64452850cb4834060806ee7aa2a34607d0ab899e5ceb97a663c524f4e0eeed"
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
