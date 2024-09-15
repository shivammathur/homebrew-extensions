# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT56 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-1.3.1.tgz"
  sha256 "18c9455e731f33770106ce971e7d4af4b95c53078a29b93669809a669f7e75b9"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "a56dac181aa0e3ff2385c4b69d74366bab19bce630ef89d98a89ef9710ce4bce"
    sha256 cellar: :any,                 arm64_ventura:  "92caaf105436e9b008dd173e2d1cf109d023cce61f915a8c077a51aa7855f816"
    sha256 cellar: :any,                 arm64_monterey: "1e00f8601175282e4d79c289ba7aeff92019888247e57114e4707650cc78d916"
    sha256 cellar: :any,                 arm64_big_sur:  "ac7f34327403380d0cb78bb0a0239666e8b5eb0436b15c6373fd6a626fde23b0"
    sha256 cellar: :any,                 ventura:        "18bd366b2b9614b4eedd3ab36ab489570b9bdaca5fe93643e6f295992191337e"
    sha256 cellar: :any,                 big_sur:        "bf531f948ac7d928e1f3a73699fa65f2304e2460869956477db5bb10ca7d67b6"
    sha256 cellar: :any,                 catalina:       "96ad38819072a1a90ade1da4da6ec021669481a2d4800d745e21c6329e837ad7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "690d6fd1a2f77a310ee676c8d18a7082bd5d8acaadb9f0231d2add0600d4a5c9"
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
