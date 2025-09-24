# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT86 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "ee6d9252b0e34f4c3dcb518418e70d59aa1962412c77da59cf223c46907956d8"
    sha256 cellar: :any,                 arm64_sequoia: "895aefa6079795c2a5d8d291664cd6d8cb80cbb20b718774655126402562992e"
    sha256 cellar: :any,                 arm64_sonoma:  "a48124036d56373a32b3b2d5060d9390a772ad8f01bd01e6bba2822bff70545a"
    sha256 cellar: :any,                 sonoma:        "3d2914de34ab94b3552247519ee0133fd5111ec5ca74d86aa2de7443ed54f992"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b5c37ea6543aa39040d5fdc40ee0d2c83ca3819fed586066e1c4151d629acba1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b4f0fda56722793975b798c0e7d6a8f91bc0cfe315db5ab66291b5e521e7a126"
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
