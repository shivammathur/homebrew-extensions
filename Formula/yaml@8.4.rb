# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "baf1c40210e11938d6d176ae45565356f89a48db89e9103cf4e937903d0a9e4a"
    sha256 cellar: :any,                 arm64_sequoia: "7c95b19899d6f4f8978a30302c477e09063e62d03980452ac5f770c62633b82b"
    sha256 cellar: :any,                 arm64_sonoma:  "cc46238a56afc724875d645d09099e580bcd66d53192dc914015ec842eb93cb1"
    sha256 cellar: :any,                 sonoma:        "613b7cb251b846c25eb8c4acba039ba2a984f292f9f16d2caef4d36f23d7687b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "64e1430789fc18ea6ab5973e2401a28da3df25a3a293a090223328efd2b8c769"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "22b151ea67fae016430950d376195e9b955bf71caf86a4ee5ea9ccb8be3c5352"
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
