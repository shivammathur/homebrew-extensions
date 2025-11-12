# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "14a03310f0a75bd9c70935064b5af4d1485b0de5a27144b71ea40465aac2e0c4"
    sha256 cellar: :any,                 arm64_sequoia: "2729aa53c9999a205d3b524a0977ee6b5b81e4addebf2c171fd4b2f96e865b04"
    sha256 cellar: :any,                 arm64_sonoma:  "19ccd995349cadc6eb708032250b0395cab4d0c3c89c25728870bfa6654d1856"
    sha256 cellar: :any,                 sonoma:        "efe532a0d105b03f4648d1ce2b88710598b25e9a972a9bf71d338092d68380ed"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8a042bcaf4fd4ff98a0053d274da53755c8e1f7f5cd083bb1273c4f62de79bdb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "73ad3fde6793be5247cfc6481f4b3c28f3caaec076fe3584ae309b0a4336f853"
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
