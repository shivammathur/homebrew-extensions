# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT81 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.4.tgz"
  sha256 "8eb353baf87f15b1b62ac6eb71c8b589685958a1fe8b0e3d22ac59560d0e8913"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "3acedc4fe2a0b8c2375b28e894ed2c89b2b7cdcf33de972e834add278c6df47a"
    sha256 cellar: :any,                 arm64_sonoma:  "b24fef69e4224609e6a18ecd9100c5585c9f1428cc7518da56807ca653d1526e"
    sha256 cellar: :any,                 arm64_ventura: "51ecaa672add0e17a59dc86787232c59017965f3b85bb543bbba7e1d8a5e6097"
    sha256 cellar: :any,                 ventura:       "1a68994261ef473d846cd73e67a14040fa1003b425600ea674f8e64d850978c8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "287a886030cc79d7c138f1cd195f8d0a974f7a7bd6c274b384e9899c8028de3e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c8a185c31fc404247a205648e0bd53e1b8b63e98550a768d648e38279838f3ff"
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
