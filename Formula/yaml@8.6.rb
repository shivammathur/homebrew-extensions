# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT86 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "c40b6da1696d19a1d4ebe8c87a6c81d6fb998d4c51c63757376eca2a1c4d82d4"
    sha256 cellar: :any,                 arm64_sequoia: "dcd3da1f8a0c14c7d5ff9dad47b041f6e7ad1d0ec902a36ba154d38206e6ac0c"
    sha256 cellar: :any,                 arm64_sonoma:  "71960684a6397793438bc25182ff2485130d7f542176fe13247bd9ee79e3a0bf"
    sha256 cellar: :any,                 sonoma:        "35de06b1185d07376adb6fde79d5e62046e2a4894640ed2e18d05b9d754f36e8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3044e7d756f04a4343416c90037f16f8db607d757e2ba8140c5b9975358a86c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b2c2b0dde10673d49eed354ea281f85fa01480b2fddfca902efe412002753d0d"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
    ]
    Dir.chdir "yaml-#{version}"
    inreplace "detect.c", "ZEND_ATOL(*lval, buf)", "*lval = ZEND_ATOL(buf)"
    %w[
      yaml.c
      parse.c
    ].each do |f|
      inreplace f, "zval_dtor", "zval_ptr_dtor_nogc"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
