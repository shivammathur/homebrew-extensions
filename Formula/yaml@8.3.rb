# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "6bdfaef124a5f5290b9caae9f84c72ae5559d8f148a0f411161bbb70dcc28db1"
    sha256 cellar: :any,                 arm64_sequoia: "482672eee01bc967f976615a44526c314d7aa040e5bc1a88e8074aa73c78824c"
    sha256 cellar: :any,                 arm64_sonoma:  "d5ae86862f2e5b67eccccaa626b92b36c3ea9f4c00a0875c16e25cfafde56ef3"
    sha256 cellar: :any,                 sonoma:        "36eaa1e26548e0b30f9c583b529ec11315e9e86ec5b432c87188c37da320f1f5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4841474589833aacfe7989bbb478a708c8fae29a72f7fd510c3ade5f682f2908"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "130b13af88be6ec7db89a03816fcb790e37c4d2f3cf91c905001a8cc5719e88c"
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
