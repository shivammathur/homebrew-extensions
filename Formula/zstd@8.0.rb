# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT80 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.0.tgz"
  sha256 "cd8bb6276f5bf44c4de759806c7c1c3ce5e1d51e2307e6a72bf8d26f84e89a51"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "2677486a0923bfccaba2aac3197169c85e8e693034bcd773c7f32c55856bab85"
    sha256 cellar: :any,                 arm64_sonoma:  "3eb95caead3e8d06448f67414530898eb9a48472ee012a65da5bbc754318d69c"
    sha256 cellar: :any,                 arm64_ventura: "f7113af5c485131b46f054e9387c7c1a0bdd0755b723b3991cabaf1482a07fc3"
    sha256 cellar: :any,                 ventura:       "7a20ad8b23bdd5fae8b0e5e86832b47776302847b8cf8793bf9d0685a09cd2d9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8e6fdae2193ea59b5a0d97670b024d4031e7f7cc392f4c0a19642d49056d850e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1c71e95efacc4d110740744d3493ac6172670e069b08c4794b94071292b6ed61"
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
