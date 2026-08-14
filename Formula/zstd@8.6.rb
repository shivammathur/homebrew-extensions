# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT86 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "ae5b52a29a78e583175d805adbec3e5011fa83422190db9ca72355c700209624"
    sha256 cellar: :any, arm64_sequoia: "c48068980cccbf3d1209a1d6b5067c98645b9ec248f42c21f51a5f1872fcf2dd"
    sha256 cellar: :any, arm64_sonoma:  "8fd116792ca45d4984d4f9c6401b828b01321a5e2cf0a1e8b525c329a1c27072"
    sha256 cellar: :any, sonoma:        "5712bb0872ee8909d4954fe0563e322b5f3106a6bcbaa4bcd32ef50648a5cc5e"
    sha256 cellar: :any, arm64_linux:   "1d966b0ad12cceda1f2e31b567f44a33584a4d4c4e9e8335410393ee3b1960a7"
    sha256 cellar: :any, x86_64_linux:  "d2e59bcae0455aac53ed97c3044036fb4aa58ea8eba99f1f40dd0505ab1029be"
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
