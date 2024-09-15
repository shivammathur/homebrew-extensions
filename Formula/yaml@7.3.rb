# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT73 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.3.tgz"
  sha256 "5937eb9722ddf6d64626799cfa024598ff2452ea157992e4e67331a253f90236"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "3494ca6db2c8fcfcef137d1392521964e2e0d989d8b6c7eba47ab849a7e13d1e"
    sha256 cellar: :any,                 arm64_ventura:  "ba45569e4329e956442913040a4ee8b1d154738c2cd67bf03fac743a7d4c4f37"
    sha256 cellar: :any,                 arm64_monterey: "a83cfca39341649f101aeba9a126acc96732964821197e382f0e3669f34d8b68"
    sha256 cellar: :any,                 arm64_big_sur:  "7abc6f5012433aeb21f899ae0b245d3716af845c43b3b434d9e5f6a8506678aa"
    sha256 cellar: :any,                 ventura:        "7698341c1b3a7fc4f82ad2d9bc601a9ead3080f5324a6f88ce1eb8d3527180ce"
    sha256 cellar: :any,                 monterey:       "bd612b3e30d967d7c3065fe66c107bd961407062cb482dd232af4c91dc465f0b"
    sha256 cellar: :any,                 big_sur:        "a3296aec63a781516e640c266bbfddabb7d7e5aafa12dd9d514bbf31bc395e61"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7eaf3a85b21f6090de1e76db975853604d2cd4ad8539b84acaa6a5be4da8a265"
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
