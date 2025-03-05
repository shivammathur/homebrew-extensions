# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT81 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.13.3.tgz"
  sha256 "e4dfa6e5501736f2f5dbfedd33b214c0c47fa98708f0a7d8c65baa95fd6d7e06"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "e90bbaf336a4b9fb201761ef8e12eacbba6ed517fd3db05ca664abe76fc37557"
    sha256 cellar: :any,                 arm64_sonoma:  "566fc034071a839b9ad3050556c2d5afd92ec5a025ee326b39db6e45e859d714"
    sha256 cellar: :any,                 arm64_ventura: "13971796c71f36a9c70b63b853c63bbc58cc2f6856fe402426a46b60149d7884"
    sha256 cellar: :any,                 ventura:       "2c5e2edff74bdc65465a7442087aa24913ebd0df35ab14d97743ba4eb6fe21c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b0356bdb8edc0a3543e861c7f5a4449574aac2900dccc76951f8c3ecafa5bf40"
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
