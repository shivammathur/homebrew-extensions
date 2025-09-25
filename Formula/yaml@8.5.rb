# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT85 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.5.tgz"
  sha256 "0c751b489749fbf02071d5b0c6bfeb26c4b863c668ef89711ecf9507391bdf71"
  revision 1
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "6c5ddb2177bacdc53af9741fc4df1eb736a44df106022dac8b06b98ff20abecc"
    sha256 cellar: :any,                 arm64_sequoia: "ce58a0ce463c5d4e265994281dfc35cf22eb70cc1d7b4f25623fce3e917e71c3"
    sha256 cellar: :any,                 arm64_sonoma:  "b838788f601a09619ee355332c6b35595591a3e25bffabdc9e6fb4ce38e4b06a"
    sha256 cellar: :any,                 sonoma:        "97ad32c1a3ba58e63b5155a7fc5615a0729e9b636168aa0c9284e2ac8a40a0c4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a9196d9831229a6bb815348b3536d9a00e1d6da4587bf0fbfe3f112e57f2217a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4058971b9a77a78fe2fe9b0671f667a8086b72d9e00d8242eca5ab41442ae67f"
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
