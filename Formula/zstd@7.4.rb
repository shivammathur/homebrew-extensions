# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT74 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.18.0.tgz"
  sha256 "223d0f77eb5a5e73cf5e7a0652dd8fde7ffdcc843e7f30eeb3998283dec847b9"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "6fa87d2bed1af374d31bc1cfa6f1674e8d3c0351a3e4c1ba56befe9837bc2923"
    sha256 cellar: :any, arm64_sequoia: "e9b7ba002b88fa69fac0ca2c8c3e70d41ced90562afe256988562f964e735456"
    sha256 cellar: :any, arm64_sonoma:  "376c58279e58b56090d7f88df93660960403bac052d5e06e5ab2af8ad72a8339"
    sha256 cellar: :any, sonoma:        "4de3dab6a5877ad71a8115dc3beb00c754cf4a1674cf33982f9bc1a5068c33d0"
    sha256 cellar: :any, arm64_linux:   "65a9e64258a66ab059488d6cee846d931f90d589c0590e9b5f23a28da0f4b5cc"
    sha256 cellar: :any, x86_64_linux:  "701c25879dd6cfec992a922286a674d01f238b61ce53a50dfb61487510353dc7"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
