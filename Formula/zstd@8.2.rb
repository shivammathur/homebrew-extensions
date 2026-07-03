# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT82 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.17.0.tgz"
  sha256 "38cf9e239e72e775bdf01fb5f1abaed76c7ce92e8d3a562a97ef96c9d0446ea0"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "6118a801b8ef2a96d08c74f57afd18d350297c065fe0ef9ae99da15a39720c28"
    sha256 cellar: :any, arm64_sequoia: "2013e7cf9dfa3be4a858577595aeae6e962bad1d1d8acf011bf7c483569ae32d"
    sha256 cellar: :any, arm64_sonoma:  "1872206b7d54b4dc8f916285f295cc15070dbccc02b9f3d3ca8d86ed4a60fff0"
    sha256 cellar: :any, sonoma:        "e41d6dc551945b8df7f086e194ad073d72728a156f9906bc6777fdc41adf3182"
    sha256 cellar: :any, arm64_linux:   "18d25fcb4a5873d904ea22df73aa63ab76c03a01a4e8a895d5d4b16dede5a389"
    sha256 cellar: :any, x86_64_linux:  "ed8191d4725df3d5102fec6857b541aa52113971a0be7d2c818f435f42ca8f32"
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
